package Test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.ssw.crud.bean.Employee;
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations= {"classpath:spring/applicationContext.xml",
								"classpath:springmvc/springmvc-servlet.xml"})
public class PageTest {
	//虚拟mvc请求获取到 处理结果
	MockMvc mockMvc;
	//传入springmvc的IOC
	@Autowired
	WebApplicationContext context;
	
	@Before
	public void init() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	@Test
	public void testPage() throws Exception {
		//模拟请求拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pageNo", "11"))
							.andReturn();
		//请求成功后，request域中会有pageInfo,可以拿pageInfo进行验证
		MockHttpServletRequest request = result.getRequest();
		PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
		System.out.println("当前页"+pageInfo.getPageNum());
		System.out.println("总页数"+pageInfo.getPages()); 
		System.out.println("总记录数"+pageInfo.getTotal());
		System.out.println(pageInfo.getPageSize());
		System.out.println("在页面需要连续显示的页数");
		int[] nums = pageInfo.getNavigatepageNums();
		for (int i : nums) {
			System.out.print(" "+i);
		}
		//获取员工数据
		List<Employee> list = pageInfo.getList();
		for (Employee employee : list) {
			System.out.println("ID"+employee.getEmpId()+"==>name"+employee.getEmpName());
		}
	}
}

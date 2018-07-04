package Test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ssw.crud.bean.Department;
import com.ssw.crud.bean.Employee;
import com.ssw.crud.dao.DepartmentMapper;
import com.ssw.crud.dao.EmployeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:spring/applicationContext.xml"})
public class MapperTest {
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;
	@Test
	public void testCRUD() {
		System.out.println(departmentMapper);
//		departmentMapper.insertSelective(new Department(null,"开发部"));
//		departmentMapper.insertSelective(new Department(null,"测试部"));
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		
		for(int i=0;i<500;i++) {
			String string = UUID.randomUUID().toString().substring(0, 5)+i;
			mapper.insertSelective(new Employee(null, string, "female", string+"@ssw.com", 2));
			
		}
	}
}


## unable to start within 45 seconds
Server Tomcat v6.0 Server at localhost was unable to start within 45 seconds. If the server requires more time, try increasing the timeout in the server editor.

修改 workspace\.metadata\.plugins\org.eclipse.wst.server.core\servers.xml文件。
<servers>
<server hostname="localhost" id="JBoss v5.0 at localhost" name="JBoss v5.0 at
localhost" runtime-id="JBoss v5.0" server-type="org.eclipse.jst.server.generic.jboss5"
server-type-id="org.eclipse.jst.server.generic.jboss5" start-timeout="1000" stop-
timeout="15" timestamp="0">
<map jndiPort="1099" key="generic_server_instance_properties" port="8090"
serverAddress="127.0.0.1" serverConfig="default"/>
</server>
</servers>
把 start-timeout="45" 改为 start-timeout="1000" 或者更长
重启eclipse就可以了。
这个原因就是：启动tomcat需要的时间比45秒大了，Eclipse会判断tomcat在默认的时间是否启动了，如果在默认45秒没有启动就会报错了

## An error has occurred. See error log for more details.
Path must include project and resource name: /struts-default.xml

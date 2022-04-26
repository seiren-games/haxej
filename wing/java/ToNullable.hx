package wing.java;

import java.javax.swing.table.TableCellEditor;
import java.javax.swing.JTable;
import java.awt.Component;
import java.javax.swing.JFrame;
import java.lang.reflect.Field;

/**
 * Avoid `@:nullSafety(Off)` in user side code.
 */

@:nullSafety(Off)
abstract JFrameNullable(JFrame) from JFrame {
	public function setLocationRelativeTo(component:Null<Component>):Void {
		this.setLocationRelativeTo(component);
	}
}

@:nullSafety(Off)
abstract FieldNullable(Field) from Field {
	public function get(param1:Null<Dynamic>):Dynamic {
		return this.get(param1);
	}
}

@:nullSafety(Off)
abstract JTableNullable(JTable) from JTable {
	public function setDefaultEditor(param1:java.lang.Class<Dynamic>, param2:Null<TableCellEditor>):Void {
		this.setDefaultEditor(param1, param2);
	}
}

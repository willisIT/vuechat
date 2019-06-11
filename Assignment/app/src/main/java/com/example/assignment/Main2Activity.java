package com.example.assignment;

import android.content.Intent;
import android.os.PersistableBundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;
import android.widget.Toast;

public class Main2Activity extends AppCompatActivity {

    private TextView txtName;
    private TextView txtIndex;
    private String name, index;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main2);

        txtName = findViewById(R.id.name_txt);
        txtIndex = findViewById(R.id.index_txt);

        Bundle	extras	=	getIntent().getExtras();
        if	(extras	==	null) {
            return;
        }

        txtName.setText(getNameResult(extras));
        txtIndex.setText(getIndexResult(extras));
    }

    @Override
    public void onSaveInstanceState(Bundle outState) {
        outState.putString("Name", getNameResult(outState));
        outState.putString("Index",getIndexResult(outState) );
        super.onSaveInstanceState(outState);

    }

    @Override
    protected void onRestoreInstanceState(Bundle savedInstanceState) {
        super.onRestoreInstanceState(savedInstanceState);
        name = savedInstanceState.getString("Name");
        index = savedInstanceState.getString("Index");
    }

    String getNameResult(Bundle extras){
        name = extras.getString("Name");
        return name;
    }
    String getIndexResult(Bundle extras){
        index = extras.getString("Index");
        return index;
    }
}

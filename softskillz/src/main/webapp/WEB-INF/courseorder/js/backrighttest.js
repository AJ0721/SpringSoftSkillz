document.querySelector("body").innerHTML += `
<div class="col-12 col-lg-3">
<div class="card">
  <div class="card-body py-4 px-4">
    <div class="d-flex align-items-center">
      <div class="avatar avatar-xl">
        <img src="/assets/compiled/jpg/1.jpg" alt="Face 1" />
      </div>
      <div class="ms-3 name">
        <h5 class="font-bold">管理員名稱</h5>
        <h6 class="text-muted mb-0">管理員帳號</h6>
      </div>
    </div>
  </div>
</div>
<!-- 右方第二個Recent Messages -->
<div class="card">
  <div class="card-header">
    <h4>Recent Messages</h4>
  </div>
  <div class="card-content pb-4">
    <div class="recent-message d-flex px-4 py-3">
      <div class="avatar avatar-lg">
        <img src="/assets/compiled/jpg/4.jpg" />
      </div>
      <div class="name ms-4">
        <h5 class="mb-1">Hank Schrader</h5>
        <h6 class="text-muted mb-0">@johnducky</h6>
      </div>
    </div>
    <div class="recent-message d-flex px-4 py-3">
      <div class="avatar avatar-lg">
        <img src="/assets/compiled/jpg/5.jpg" />
      </div>
      <div class="name ms-4">
        <h5 class="mb-1">Dean Winchester</h5>
        <h6 class="text-muted mb-0">@imdean</h6>
      </div>
    </div>
    <div class="recent-message d-flex px-4 py-3">
      <div class="avatar avatar-lg">
        <img src="/assets/compiled/jpg/1.jpg" />
      </div>
      <div class="name ms-4">
        <h5 class="mb-1">John Dodol</h5>
        <h6 class="text-muted mb-0">@dodoljohn</h6>
      </div>
    </div>
    <div class="px-4">
      <button class="btn btn-block btn-xl btn-outline-primary font-bold mt-3">
        Start Conversation
      </button>
    </div>
  </div>
</div>
</div>
</section>
</div>

`
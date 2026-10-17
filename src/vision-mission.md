---
layout: layouts/page.njk
title: Vision & Mission
contentPadding: pt-10 pb-16 md:pt-14 md:pb-24
heroStrip:
  - /img/images2/vision/2.jpg
  - /img/images2/vision/1.jpg
permalink: /vision-mission/
---

<style>
    .vm-eyebrow {
        font-family: 'Outfit', system-ui, sans-serif;
        font-size: .6875rem;
        font-weight: 800;
        letter-spacing: .22em;
        text-transform: uppercase;
        color: #E97130;
        margin: 0 0 1.25rem;
    }
    .vm-statement {
        position: relative;
        padding: 0 0 0 3.5rem;
        border-left: 4px solid #2f3192;
    }
    .vm-statement::before {
        content: '\201C';
        position: absolute;
        left: 1rem;
        top: -0.6rem;
        font-family: 'Outfit', Georgia, serif;
        font-size: 3.25rem;
        line-height: 1;
        color: #e0e2ff;
        z-index: 0;
    }
    .vm-statement p {
        position: relative;
        z-index: 1;
        font-family: 'Outfit', system-ui, sans-serif;
        font-size: 1.25rem;
        line-height: 1.6;
        font-weight: 500;
        color: #1e293b;
        margin: 0;
    }
    @media (min-width: 768px) {
        .vm-statement { padding-left: 4rem; }
        .vm-statement p { font-size: 1.5rem; line-height: 1.55; }
        .vm-statement::before { font-size: 3.25rem; top: -0.5rem; left: 1.25rem; }
    }

    .vm-lead {
        font-size: 1.25rem !important;
        line-height: 1.6 !important;
        color: #1e293b !important;
        max-width: 46rem;
    }
    .content-area p { color: #475569; }

    .vm-grid {
        display: grid;
        grid-template-columns: 1fr;
        gap: 1.25rem;
        margin: 2.5rem 0 0;
    }
    @media (min-width: 640px) { .vm-grid { grid-template-columns: 1fr 1fr; } }

    .vm-pillar {
        display: flex;
        flex-direction: column;
        background: #fff;
        border: 1px solid #e2e8f0;
        border-radius: 1rem;
        padding: 1.75rem;
        transition: transform .25s ease, box-shadow .25s ease, border-color .25s ease;
    }
    .vm-pillar:hover {
        transform: translateY(-4px);
        box-shadow: 0 20px 40px -24px rgba(15,23,42,.5);
        border-color: #c7caff;
    }
    .vm-pillar-icon {
        width: 3rem; height: 3rem;
        border-radius: .875rem;
        display: flex; align-items: center; justify-content: center;
        font-size: 1.125rem;
        color: #2f3192;
        background: #f0f1ff;
        margin-bottom: 1.125rem;
        transition: background .25s ease, color .25s ease;
    }
    .vm-pillar:hover .vm-pillar-icon { background: #2f3192; color: #fff; }
    .vm-pillar h3 {
        font-family: 'Outfit', system-ui, sans-serif;
        font-size: 1.0625rem;
        font-weight: 700;
        color: #0f172a;
        line-height: 1.4;
        margin: 0 0 .5rem;
    }
    .vm-pillar p {
        font-size: .9375rem;
        line-height: 1.7;
        color: #334155;
        margin: 0 0 1.25rem;
    }
    .vm-pillar-links {
        margin-top: auto;
        display: flex;
        flex-wrap: wrap;
        gap: .5rem;
    }
    .vm-pillar-links a {
        font-size: .75rem;
        font-weight: 600;
        color: #2f3192;
        background: #f0f1ff;
        border-radius: 9999px;
        padding: .375rem .75rem;
        text-decoration: none;
        transition: background .2s ease, color .2s ease;
    }
    .vm-pillar-links a:hover { background: #2f3192; color: #fff; }
</style>

<section>
        <p class="vm-eyebrow">Our Vision</p>
        <div class="vm-statement">
            <p>To create an inclusive, just, and compassionate society where every individual has access to quality education, healthcare, dignity, and sustainable livelihood opportunities, enabling people and communities to live with equality, security, and hope.</p>
        </div>
    </section>

    <section class="mt-14 md:mt-20">
        <h2>Our Mission</h2>
        <p class="vm-lead">Our mission is rooted in equality, dignity, compassion, and inclusive development. We are committed to serving humanity without discrimination based on caste, creed, gender, religion, or social and economic status.</p>
        <p>We work to empower underprivileged and marginalized communities through four pillars of work.</p>

        <div class="vm-grid">
            <div class="vm-pillar">
                <div class="vm-pillar-icon"><i class="fa-solid fa-graduation-cap"></i></div>
                <h3>Education and Skill Development</h3>
                <p>Creating opportunities for learning, capacity building, and employable skills.</p>
                <div class="vm-pillar-links">
                    <a href="/educational-activities/">Educational Activities</a>
                    <a href="/savitribai-scholarships/">Scholarships</a>
                    <a href="/shankar-narayan-library/">Library</a>
                </div>
            </div>
            <div class="vm-pillar">
                <div class="vm-pillar-icon"><i class="fa-solid fa-people-group"></i></div>
                <h3>Women and Youth Empowerment</h3>
                <p>Strengthening leadership, independence, confidence, and livelihood opportunities among women and young people.</p>
                <div class="vm-pillar-links">
                    <a href="/women-empowerment/">Women Empowerment</a>
                </div>
            </div>
            <div class="vm-pillar">
                <div class="vm-pillar-icon"><i class="fa-solid fa-heart-pulse"></i></div>
                <h3>Healthcare and Rehabilitation</h3>
                <p>Promoting access to healthcare, rehabilitation, and support services for vulnerable individuals and communities.</p>
                <div class="vm-pillar-links">
                    <a href="/health-care/">Healthcare</a>
                    <a href="/medical-camps/">Medical Camps</a>
                </div>
            </div>
            <div class="vm-pillar">
                <div class="vm-pillar-icon"><i class="fa-solid fa-hand-holding-heart"></i></div>
                <h3>Community Development and Disaster Relief</h3>
                <p>Strengthening communities through sustainable development initiatives and providing timely assistance and relief during disasters and emergencies.</p>
                <div class="vm-pillar-links">
                    <a href="/relief-operations/">Relief Operations</a>
                    <a href="/children-home/">Children Home</a>
                </div>
            </div>
        </div>

    </section>

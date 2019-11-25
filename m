Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62897108A59
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2019 09:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfKYIxY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Nov 2019 03:53:24 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:57701 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfKYIxY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Nov 2019 03:53:24 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191125085316epoutp01019a673a1d68a66641530838c77c27f9~aW9aHYeeG2690626906epoutp01X
        for <linux-can@vger.kernel.org>; Mon, 25 Nov 2019 08:53:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191125085316epoutp01019a673a1d68a66641530838c77c27f9~aW9aHYeeG2690626906epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574671996;
        bh=hkKc1+Kc6J/ubgIm1I00LCzEChlMLIEt1GnUxcZWorU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=LKLv0NHJUr8r4cNfTOos7pzSNoFUoRqY9YiFZr5o1nSZVEpFlCTDVUHbpZr6qaaW2
         Zbub10c/6wyRfh7WGwSjHGrPdOy/dBuxByEzdRMWZ0x+VH80VR6H0mwAgYQve9MQ55
         k5EXKw3AJ+J9Gz56nlcU792sFpx9AMxi+pLEAHkE=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20191125085316epcas5p247d263bb0ca079afda1296d58665be23~aW9ZrIdrp1642816428epcas5p2D;
        Mon, 25 Nov 2019 08:53:16 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.20.19726.C769BDD5; Mon, 25 Nov 2019 17:53:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20191125085315epcas5p23592bc5a332e226ff7db34e9c2ee94ef~aW9ZWqQ341642816428epcas5p2C;
        Mon, 25 Nov 2019 08:53:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191125085315epsmtrp20e78ee964e774ff4f13256b7446831c3~aW9ZV9zP_1368013680epsmtrp27;
        Mon, 25 Nov 2019 08:53:15 +0000 (GMT)
X-AuditID: b6c32a49-7a9ff70000014d0e-a9-5ddb967c81e9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.4D.10238.B769BDD5; Mon, 25 Nov 2019 17:53:15 +0900 (KST)
Received: from sriramdash03 (unknown [107.111.85.29]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191125085313epsmtip145d2aed6a51babe795e5338748f54d82~aW9Xgd_6Q2458824588epsmtip1Z;
        Mon, 25 Nov 2019 08:53:13 +0000 (GMT)
From:   "Sriram Dash" <sriram.dash@samsung.com>
To:     "'Marc Kleine-Budde'" <mkl@pengutronix.de>,
        "'Pankaj Sharma'" <pankj.sharma@samsung.com>,
        <linux-can@vger.kernel.org>
Cc:     <wg@grandegger.com>, <dmurphy@ti.com>, <rcsekar@samsung.com>,
        <pankaj.dubey@samsung.com>
In-Reply-To: <24bfd497-c338-e1e2-e9c5-53d76fcc4abf@pengutronix.de>
Subject: RE: [PATCH 0/2] can: m_can_platform: Bug fix of kernel panic for
Date:   Mon, 25 Nov 2019 14:23:11 +0530
Message-ID: <028101d5a36d$c693b7b0$53bb2710$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE7rWdEBMvebVKOOOKqXHxmn9mClwHtd6OFAmgYEs+orNFBQA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7bCmlm7NtNuxBpubuSy6T29htVj1fSqz
        xfpFU1gsFm39wm6xvOs+s8WsCztYLZbe28nqwO7x8dJtRo/+vwYefVtWMXocv7GdyePzJrkA
        1igum5TUnMyy1CJ9uwSujF+vn7MUbJCqWPPwHFMD40+RLkZODgkBE4nv724zdzFycQgJ7GaU
        aFy1iR3C+cQoceB7F1TmG6PE7+9H2WBaGneegErsZZSYNe89E4TzilHi3aJzTCBVbAK6Emdv
        NIF1iAhUS7yZfQzMZhaIk5h1fi07iM0p4CSx7uo/MFtYwFNiffNaVhCbRUBV4tPCNhYQm1fA
        UmLVq/3sELagxMmZT1gg5mhLLFv4mhniIgWJn0+XsULscpKYsnMTVI24xNGfPVA1r9kk7j9w
        g7BdJFZsOsEEYQtLvDq+hR3ClpL4/G4v1JfZEpf7nkP1lkjMeLWQBcK2lzhwZQ6QzQE0X1Ni
        /S59iFV8Er2/nzCBhCUEeCU62oQgqlUlXt3eDDVdWuLA2tNQWz0kJi84wDKBUXEWksdmIXls
        FpIHZiEsW8DIsopRMrWgODc9tdi0wDAvtVyvODG3uDQvXS85P3cTIzgJaXnuYJx1zucQowAH
        oxIP74a1t2KFWBPLiitzDzFKcDArifC6nb0RK8SbklhZlVqUH19UmpNafIhRmoNFSZx3EuvV
        GCGB9MSS1OzU1ILUIpgsEwenVAOjiqM+HxNHcsuyYtYzvHLKyS8nnbjd0v+4PsmAS7hgGjvX
        igOnuFpzJju5J8dK2Gbyyunc3bTwckOqbay/nJb3Gvlr5WvWxbK0vZ/cqlFtOs1jmnL7vVvh
        YSftdfT7Lr/5kyW+LmHeppzMH1e2brne+6WL6emr4L2fI8+E/Z035azJ4epEvqVKLMUZiYZa
        zEXFiQDWixyGPgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJTrd62u1Yg3vntC26T29htVj1fSqz
        xfpFU1gsFm39wm6xvOs+s8WsCztYLZbe28nqwO7x8dJtRo/+vwYefVtWMXocv7GdyePzJrkA
        1igum5TUnMyy1CJ9uwSujA17+tgKVkhWvGk6wdzA+FK4i5GTQ0LARKJx5wnmLkYuDiGB3YwS
        n77tYu1i5ABKSEv8vKsLUSMssfLfc3aImheMEjtvTGICSbAJ6EqcvdHEBmKLCNRKfHvzGMxm
        FkiSaF29nBHEFhI4zygxc1U4iM0p4CSx7uo/dhBbWMBTYn3zWlYQm0VAVeLTwjYWEJtXwFJi
        1av97BC2oMTJmU9YIGZqS/Q+bGWEsZctfM0McZyCxM+ny1ghbnCSmLJzE1S9uMTRnz3MExiF
        ZyEZNQvJqFlIRs1C0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwLGlp7mC8
        vCT+EKMAB6MSD++GtbdihVgTy4orcw8xSnAwK4nwup29ESvEm5JYWZValB9fVJqTWnyIUZqD
        RUmc92nesUghgfTEktTs1NSC1CKYLBMHp1QDo9t1aSeR9R6hXcX5u6Rzd3RWf/P2X77Y5M9P
        abNPk9ZJKddOVrp0v45p15ujGsyheycu7FrJJ3lARG/a7lfFl8vXLHOrfrk949wSN6Gs3Gaj
        XXO9InWbWPIlA3PWGWXLZAnnr6u98tnyxN+L3+ey2di4ra2e90v4sadc+CqF8LClHdb/TKKj
        lFiKMxINtZiLihMBCcMXgKECAAA=
X-CMS-MailID: 20191125085315epcas5p23592bc5a332e226ff7db34e9c2ee94ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191119102134epcas5p4d3c1b18203e2001c189b9fa7a0e3aab5
References: <CGME20191119102134epcas5p4d3c1b18203e2001c189b9fa7a0e3aab5@epcas5p4.samsung.com>
        <1574158838-4616-1-git-send-email-pankj.sharma@samsung.com>
        <24bfd497-c338-e1e2-e9c5-53d76fcc4abf@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> From: Marc Kleine-Budde <mkl=40pengutronix.de>
> Subject: Re: =5BPATCH 0/2=5D can: m_can_platform: Bug fix of kernel panic=
 for
>=20
> On 11/19/19 11:20 AM, Pankaj Sharma wrote:
> > The current code is failing while clock prepare enable because of not
> > getting proper clock from platform device.
> >
> > =5B    0.852089=5D Call trace:
> > =5B    0.854516=5D  0xffff0000fa22a668
> > =5B    0.857638=5D  clk_prepare+0x20/0x34
> > =5B    0.861019=5D  m_can_runtime_resume+0x2c/0xe4
> > =5B    0.865180=5D  pm_generic_runtime_resume+0x28/0x38
> > =5B    0.869770=5D  __rpm_callback+0x16c/0x1bc
> > =5B    0.873583=5D  rpm_callback+0x24/0x78
> > =5B    0.877050=5D  rpm_resume+0x428/0x560
> > =5B    0.880517=5D  __pm_runtime_resume+0x7c/0xa8
> > =5B    0.884593=5D  m_can_clk_start.isra.9.part.10+0x1c/0xa8
> > =5B    0.889618=5D  m_can_class_register+0x138/0x370
> > =5B    0.893950=5D  m_can_plat_probe+0x120/0x170
> > =5B    0.897939=5D  platform_drv_probe+0x4c/0xa0
> > =5B    0.901924=5D  really_probe+0xd8/0x31c
> > =5B    0.905477=5D  driver_probe_device+0x58/0xe8
> > =5B    0.909551=5D  device_driver_attach+0x68/0x70
> > =5B    0.913711=5D  __driver_attach+0x9c/0xf8
> > =5B    0.917437=5D  bus_for_each_dev+0x50/0xa0
> > =5B    0.921251=5D  driver_attach+0x20/0x28
> > =5B    0.924804=5D  bus_add_driver+0x148/0x1fc
> > =5B    0.928617=5D  driver_register+0x6c/0x124
> > =5B    0.932431=5D  __platform_driver_register+0x48/0x50
> > =5B    0.937113=5D  m_can_plat_driver_init+0x18/0x20
> > =5B    0.941446=5D  do_one_initcall+0x4c/0x19c
> > =5B    0.945259=5D  kernel_init_freeable+0x1d0/0x280
> > =5B    0.949591=5D  kernel_init+0x10/0x100
> > =5B    0.953057=5D  ret_from_fork+0x10/0x18
> > =5B    0.956614=5D Code: 00000000 00000000 00000000 00000000 (fa22a668)
> > =5B    0.962681=5D ---=5B end trace 881f71bd609de763 =5D---
> > =5B    0.967301=5D Kernel panic - not syncing: Attempted to kill init=
=21
> exitcode=3D0x0000000b
> >
> > A device driver for CAN controller hardware registers itself with the
> > Linux network layer as a network device. So, the driver data for m_can
> > should ideally be of type net_device.
> >
> > Further even when passing the proper net device in probe function the
> > code was hanging because of the function m_can_runtime_resume()
> > getting recursively called from m_can_class_resume().
> >
> > Pankaj Sharma (2):
> >   can: m_can_platform: set net_device structure as driver data
> >   can: m_can_platform: remove unnecessary m_can_class_resume() call
>=20
> For the m_can driver I'm looking for a maintainer. Would be fine if someo=
ne
> has a look at the mmio and someone else at the spi part.
>=20

Hello Marc,

I am currently working on MMIO MCAN for some of our customers.
We have some improvements lined up in the coming future related to m_can.
I am happy to take up the maintainership for the mmio part.

Regards,
Sriram

> Marc
>=20
> --
> Pengutronix e.K.                 =7C Marc Kleine-Budde           =7C
> Embedded Linux                   =7C https://protect2.fireeye.com/url?k=
=3D34d1e439-
> 6901ecd1-34d06f76-000babff32e3-
> 295eaf068a33066f&u=3Dhttps://www.pengutronix.de/  =7C
> Vertretung West/Dortmund         =7C Phone: +49-231-2826-924     =7C
> Amtsgericht Hildesheim, HRA 2686 =7C Fax:   +49-5121-206917-5555 =7C



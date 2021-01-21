Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E802FE529
	for <lists+linux-can@lfdr.de>; Thu, 21 Jan 2021 09:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbhAUIio (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 21 Jan 2021 03:38:44 -0500
Received: from mail-eopbgr140054.outbound.protection.outlook.com ([40.107.14.54]:55746
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728049AbhAUIi0 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 21 Jan 2021 03:38:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i34Wp8JqR5pQZwCoOPMQhNf4TZbUwAMRSkFLWDaQLGMF+NN3Z8ahj4v430SJl3FZRXvus0eBWgL5lQlux/POv4nojHSv6/IqUW28fy8mTahswWtiNRVDPSuK3wLJglsyr7vb+dxhuAHKs0xVbK0FA54t9JGCs3iPUdhKfIfKN2Zkq7klh4ajxxrnETRkrqkrhEk2ml/SQQ1Ra/9xKYJX4ytWn8zsR0jQBSctMXQR+E04Z8rjcMMV13QAM64A1MDLrngO7h2HgGtej8t8O1jxBohoM1U6YtFH5zFXTqwcB+eAeu+wugS85KaKOkNfGIoywb++tbNZyQzCCxDw1MtQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pL2qfnWIcpz2p4NUH+q5NsdSQ7F/j61hkm2fAEMRfk4=;
 b=MeU0bvU8yVt8oxcMn2J+YQGF1k65StzxDBLiO1mDHqktujl2zWm9dmovviaJF3Dd4bToYG5umYOxlS2rX+FX01mnM1j+Vleq8kR0bTqA/dElDuJ4b6akgblmwdcy1MZX00Ar1SjziRsLVPrXNM0xYnAvrhx3f3dPtbr+y4N+SjqjzeVAzb9xud2c2SWGG+v5h1lTOP8x29JOGxrZpKWxRj1DhvITP8UHGEeaZP16k2L2a9yZmARt3ZxiA9AEJKLZ0ebBCRXyR9NVk5ChFMGm8qyUVd3idk8Yqe8bMPL3e8Kyx0CRIgNiRv53dhdQm9nvANoz6ZWMVdx8lMA8O/aV0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pL2qfnWIcpz2p4NUH+q5NsdSQ7F/j61hkm2fAEMRfk4=;
 b=TEk2I8lRbBrIfNA08J/GKyLqSdAQfTbUS93SJFJEiPkTyb3LGsbFTyDCbpzRI+/jbpX4cBMMLQ4HX6C4ILoNfLd/rFzqLZ8FDoHlmg2mEsKI2AJDEm57fLcp0izrkjSy6suISjDhC/5KpbqUTEt2ModZ2OTT/VM0OeQqx7OPgPM=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB3PR0402MB3769.eurprd04.prod.outlook.com (2603:10a6:8:f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Thu, 21 Jan
 2021 08:37:31 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666%4]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 08:37:31 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: [5.10 CAN BUG report] kernel dump about echo skb
Thread-Topic: [5.10 CAN BUG report] kernel dump about echo skb
Thread-Index: Adbv0JcY0ZF9qkIgQu6uosJiCy92lA==
Date:   Thu, 21 Jan 2021 08:37:31 +0000
Message-ID: <DB8PR04MB6795E0155F4523CA9D4AAC1CE6A10@DB8PR04MB6795.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 73fc3200-6389-43e6-a0b3-08d8bde7cb38
x-ms-traffictypediagnostic: DB3PR0402MB3769:
x-microsoft-antispam-prvs: <DB3PR0402MB3769CBC0CC9FF2B085B52DE4E6A10@DB3PR0402MB3769.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zS6e02i9b0BjFEFn0prjQtJDgbBDSxAn9vbCfPiBq40fSpb3ZTaKJkh3l3eGGRJN4V0APSMLFCiD1nVeSihqMpMEQtEuDn9m62gEo48s3g5C4oQxALyH+OjHWsCbHICPSeDTog01dD80SXH8ZYWedShQ5mF2KljwkgHYpV4rGn1Fab7O+L8Zbf0QX5XQ2iPH/QINdlpArIz9Px9lc1StA0/+Kdr73tEx+1p4ngJV+HcRMgQWz3LblGJCB3K4tf7HYk3a6MO22gEYVxPgq/gwktzw5fxBHk+f4R1kIIg3cyC22oZ7Ddpb/7IMbgcnuD8Zu7QHkRKm9HmKm4pJew9SV/xKYVqGAZmlx6esdnVV8DlBwTGEWXEeZ2b6lUMA6U3bmCUJni/6+BAGxjQb9WaTQMj+OQIocxwr4rJaSdBMQEA6vd7UtF7FJmJz1ROJOIxEClunsIgFeVRB/FQrMTiS1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(26005)(6506007)(478600001)(55016002)(66476007)(33656002)(5660300002)(76116006)(9686003)(83380400001)(186003)(66446008)(86362001)(52536014)(7696005)(8936002)(64756008)(66556008)(4326008)(2906002)(8676002)(966005)(316002)(54906003)(71200400001)(110136005)(66946007)(45080400002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: nehJMwCEUH/5TNakr65BYHfhe64SEC2eQW/llictEgdR7ELD6bicu/vdC7ErlPS50P19ASFl10Dir2LQnPj7d7Hpq0AqrodDwvMclASjtQpP+f0XlU7GX5mgcfJFjAcG8oNZMe8R2jBfjHLKMLwt9/2H4Jnz66Z1DtGVvE3iKDcr09ze2JM3awJUuSnaOQGrzOLiwhKAjAzjm6ExZ2XO+TtB34rNhVMTcUirMnbUJxsSn8W0R98cUl/TCvg84RDVprc+P+kBsf+E3CU3wgn/kFmISmMZzpubv2smE0DmK0Lo5OJdAAgHiWZjSP5EH0vCyShqab/nXG59gUYwIxTJNwxKo+qjD9mzhU8/6K8oD9z3zlpUiEYYRTFmm0GnPaxpdyqTMYX8MH5AjUEqf4ZOyT2G+GYiJPhmc/ZKaQNFP4NIRkMxoSV0GHAbXONkMLk2XNeMEutBFfpOuOXyiXiuQ0cPMlFpMhLmLFksl6q87IZ2QjsWM8xgwFrsS49Tpa7/Nz//nDNUGi+4zDFSGRsW7VQ8Bttns0x0MTv0N0U1792mz4M+NvOstD5d43F+YLcX3XX9AKfnI4J9Zt3GHk05moqwhDLnZscs1xl3fSZHyDuaP0H7LeNnYLsOU3ti8oNm3HDw6n7DYgROi2OYyP0qg8JG5DlREPEI48AaJ+cA33IAc3Zymj3y2YEa5AFYhEB3whF+uBjm43w1HiwEQVfhhRjsYrf+Nhl477g9ePazHQQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fc3200-6389-43e6-a0b3-08d8bde7cb38
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 08:37:31.6172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ITTjvv1lYFCjT5B4whUB4gCZKN4tWXI/k5Cj121jDS41sCKZld0c374xESWJrka0fxdNLlc7EI+JPRMapmVww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3769
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


Hi Marc, Oleksij, Oliver,

Our auto test scripts reports below kernel dump, after revert Oleksij Rempe=
l patch "286228d382ba can: can_create_echo_skb(): fix echo skb generation: =
always use skb_clone()", this issue disappeared.
What strange is that, commit message intends to fix this issue. Report it h=
ere to see if anyone meets the same issue or can give some suggestions. I w=
ill continue to dig how to reproduce it manually, now
I don't know how to do it. Thanks.

1. Kernel dump log:
[  101.688327] ------------[ cut here ]------------
[  101.692968] refcount_t: addition on 0; use-after-free.
[  101.698210] WARNING: CPU: 0 PID: 0 at lib/refcount.c:25 refcount_warn_sa=
turat
e+0x98/0x140
[  101.706386] Modules linked in:
[  101.709446] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.4-100715-gc60=
abf9c
2110-dirty #376
[  101.717881] Hardware name: NXP i.MX8MPlus EVK board (DT)
[  101.723193] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=3D--)
[  101.729200] pc : refcount_warn_saturate+0x98/0x140
[  101.733990] lr : refcount_warn_saturate+0x98/0x140
[  101.738778] sp : ffff800011bcbcd0
[  101.742090] x29: ffff800011bcbcd0 x28: ffff0000c16b7000
[  101.747405] x27: 0000000000000000 x26: ffff0000c1718000
[  101.752718] x25: 00000000048c0000 x24: ffff0000c1e54c00
[  101.758031] x23: 0000000000000000 x22: ffff0000c1718900
[  101.763345] x21: ffff0000c1718000 x20: ffff0000c1f00800
[  101.768661] x19: ffff0000c1985e00 x18: 0000000000000010
[  101.773974] x17: 0000000000000000 x16: 0000000000000000
[  101.779287] x15: 0000000000000229 x14: ffff8000119d2cb8
[  101.784600] x13: 00000000ffffffea x12: ffff800011a51b60
[  101.789914] x11: 0000000000000003 x10: ffff800011a39b78
[  101.795227] x9 : 0000000000017fe8 x8 : ffff800011a39b20
[  101.800543] x7 : c0000000ffffefff x6 : 0000000000000001
[  101.805858] x5 : 0000000000000000 x4 : ffff00017f36f900
[  101.811174] x3 : ffff00017f376830 x2 : ffff00017f36f900
[  101.816487] x1 : 5ead5e088841e800 x0 : 0000000000000000
[  101.821800] Call trace:
[  101.824248]  refcount_warn_saturate+0x98/0x140
[  101.828694]  can_put_echo_skb+0x154/0x190
[  101.832704]  flexcan_start_xmit+0x188/0x240
[  101.836888]  dev_hard_start_xmit+0xe0/0x1a8
[  101.841072]  sch_direct_xmit+0x11c/0x338
[  101.844995]  __qdisc_run+0x118/0x5d8
[  101.848570]  net_tx_action+0x110/0x1a8
[  101.852319]  efi_header_end+0x120/0x264
[  101.856156]  irq_exit+0xb8/0xd8
[  101.859298]  __handle_domain_irq+0x64/0xb8
[  101.863396]  gic_handle_irq+0x54/0x118
[  101.867145]  el1_irq+0xc0/0x180
[  101.870288]  cpuidle_enter_state+0x130/0x2e8
[  101.874560]  cpuidle_enter+0x34/0x48
[  101.878136]  call_cpuidle+0x18/0x38
[  101.881627]  do_idle+0x1f4/0x258
[  101.884854]  cpu_startup_entry+0x20/0x68
[  101.888778]  rest_init+0xd4/0xe0
[  101.892008]  arch_call_rest_init+0xc/0x14
[  101.896019]  start_kernel+0x470/0x4a4
[  101.899681] ---[ end trace 8de9661669c150a6 ]---
[  101.908725] ------------[ cut here ]------------
[  101.913379] refcount_t: underflow; use-after-free.
[  101.918360] WARNING: CPU: 0 PID: 9 at lib/refcount.c:28 refcount_warn_sa=
turat
e+0xec/0x140
[  101.926544] Modules linked in:
[  101.929605] CPU: 0 PID: 9 Comm: ksoftirqd/0 Tainted: G        W         =
5.10.
4-100715-gc60abf9c2110-dirty #376
[  101.939603] Hardware name: NXP i.MX8MPlus EVK board (DT)
[  101.944914] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=3D--)
[  101.950921] pc : refcount_warn_saturate+0xec/0x140
[  101.955709] lr : refcount_warn_saturate+0xec/0x140
[  101.960497] sp : ffff800011c73b00
[  101.963809] x29: ffff800011c73b00 x28: 000000000000003d
[  101.969123] x27: ffff00017f37a880 x26: ffff800011c73d48
[  101.974435] x25: 000000000000012c x24: ffff800011c73d58
[  101.979748] x23: ffff0000c1718000 x22: 0000000000000000
[  101.985061] x21: ffff800011affcc0 x20: ffff0000c13eeb80
[  101.990374] x19: ffff0000c1f00800 x18: 0000000000000010
[  101.995686] x17: 0000000000000000 x16: 0000000000000000
[  102.000999] x15: 0000000000000258 x14: ffff0000c007f278
[  102.006311] x13: 00000000ffffffea x12: ffff800011a51b60
[  102.011624] x11: 0000000000000003 x10: ffff800011a39b78
[  102.016936] x9 : 0000000000017fe8 x8 : ffff800011a39b20
[  102.022249] x7 : c0000000ffffefff x6 : 0000000000000001
[  102.027562] x5 : 0000000000000000 x4 : ffff00017f36f900
[  102.032874] x3 : ffff00017f376830 x2 : ffff00017f36f900
[  102.038187] x1 : b6fa97510f7af300 x0 : 0000000000000000
[  102.043500] Call trace:
[  102.045947]  refcount_warn_saturate+0xec/0x140
[  102.050391]  sock_efree+0x6c/0x78
[  102.053707]  skb_release_head_state+0x40/0xb0
[  102.058065]  skb_release_all+0x14/0x30
[  102.061813]  kfree_skb+0x2c/0x88
[  102.065041]  can_receive+0xb4/0xf8
[  102.068442]  can_rcv+0x3c/0xc0
[  102.071496]  __netif_receive_skb_one_core+0x50/0x78
[  102.076373]  __netif_receive_skb+0x14/0x60
[  102.080468]  netif_receive_skb+0x34/0xc0
[  102.084392]  can_rx_offload_napi_poll+0x60/0xd8
[  102.088921]  net_rx_action+0x114/0x378
[  102.092670]  efi_header_end+0x120/0x264
[  102.096506]  run_ksoftirqd+0x44/0x58
[  102.100081]  smpboot_thread_fn+0x1b4/0x270
[  102.104177]  kthread+0x138/0x158
[  102.107405]  ret_from_fork+0x10/0x18
[  102.110979] ---[ end trace 8de9661669c150a7 ]---

2. Patch introduces issue:
commit 286228d382ba6320f04fa2e7c6fc8d4d92e428f4
Author: Oleksij Rempel <o.rempel@pengutronix.de>
Date:   Wed Dec 18 09:39:02 2019 +0100

    can: can_create_echo_skb(): fix echo skb generation: always use skb_clo=
ne()

    All user space generated SKBs are owned by a socket (unless injected in=
to the
    key via AF_PACKET). If a socket is closed, all associated skbs will be =
cleaned
    up.

    This leads to a problem when a CAN driver calls can_put_echo_skb() on a
    unshared SKB. If the socket is closed prior to the TX complete handler,
    can_get_echo_skb() and the subsequent delivering of the echo SKB to all
    registered callbacks, a SKB with a refcount of 0 is delivered.

    To avoid the problem, in can_get_echo_skb() the original SKB is now alw=
ays
    cloned, regardless of shared SKB or not. If the process exists it can n=
ow
    safely discard its SKBs, without disturbing the delivery of the echo SK=
B.

    The problem shows up in the j1939 stack, when it clones the incoming sk=
b, which
    detects the already 0 refcount.

    We can easily reproduce this with following example:

    testj1939 -B -r can0: &
    cansend can0 1823ff40#0123

    WARNING: CPU: 0 PID: 293 at lib/refcount.c:25 refcount_warn_saturate+0x=
108/0x174
    refcount_t: addition on 0; use-after-free.
    Modules linked in: coda_vpu imx_vdoa videobuf2_vmalloc dw_hdmi_ahb_audi=
o vcan
    CPU: 0 PID: 293 Comm: cansend Not tainted 5.5.0-rc6-00376-g9e20dcb7040d=
 #1
    Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
    Backtrace:
    [<c010f570>] (dump_backtrace) from [<c010f90c>] (show_stack+0x20/0x24)
    [<c010f8ec>] (show_stack) from [<c0c3e1a4>] (dump_stack+0x8c/0xa0)
    [<c0c3e118>] (dump_stack) from [<c0127fec>] (__warn+0xe0/0x108)
    [<c0127f0c>] (__warn) from [<c01283c8>] (warn_slowpath_fmt+0xa8/0xcc)
    [<c0128324>] (warn_slowpath_fmt) from [<c0539c0c>] (refcount_warn_satur=
ate+0x108/0x174)
    [<c0539b04>] (refcount_warn_saturate) from [<c0ad2cac>] (j1939_can_recv=
+0x20c/0x210)
    [<c0ad2aa0>] (j1939_can_recv) from [<c0ac9dc8>] (can_rcv_filter+0xb4/0x=
268)
    [<c0ac9d14>] (can_rcv_filter) from [<c0aca2cc>] (can_receive+0xb0/0xe4)
    [<c0aca21c>] (can_receive) from [<c0aca348>] (can_rcv+0x48/0x98)
    [<c0aca300>] (can_rcv) from [<c09b1fdc>] (__netif_receive_skb_one_core+=
0x64/0x88)
    [<c09b1f78>] (__netif_receive_skb_one_core) from [<c09b2070>] (__netif_=
receive_skb+0x38/0x94)
    [<c09b2038>] (__netif_receive_skb) from [<c09b2130>] (netif_receive_skb=
_internal+0x64/0xf8)
    [<c09b20cc>] (netif_receive_skb_internal) from [<c09b21f8>] (netif_rece=
ive_skb+0x34/0x19c)
    [<c09b21c4>] (netif_receive_skb) from [<c0791278>] (can_rx_offload_napi=
_poll+0x58/0xb4)

    Fixes: 0ae89beb283a ("can: add destructor for self generated skbs")
    Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
    Link: http://lore.kernel.org/r/20200124132656.22156-1-o.rempel@pengutro=
nix.de
    Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
    Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Best Regards,
Joakim Zhang


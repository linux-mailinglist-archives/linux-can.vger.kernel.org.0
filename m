Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D5C5796EC
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 11:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiGSJ6u (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 05:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237419AbiGSJ6t (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 05:58:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725783122B
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 02:58:46 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1oDk04-0002yL-96; Tue, 19 Jul 2022 11:58:44 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1oDk03-0001R6-Sq; Tue, 19 Jul 2022 11:58:43 +0200
Date:   Tue, 19 Jul 2022 11:58:43 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     "Kaesbauer, Michael" <Michael.Kaesbauer@krones.com>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Massive kernel messages by can_create_echo_skb()
Message-ID: <20220719095843.GK24373@pengutronix.de>
References: <AM0PR05MB57628BBAD26128E47F9850608F8C9@AM0PR05MB5762.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR05MB57628BBAD26128E47F9850608F8C9@AM0PR05MB5762.eurprd05.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Michael,

On Mon, Jul 18, 2022 at 02:30:29PM +0000, Kaesbauer, Michael wrote:
> Hello Oleksij,
> 
> after updating from kernel version 4.17.10 to 4.19.237 I am facing massive kernel messages when sending CAN telegrams via an CC770 compatible controller by using the drivers cc770.ko and can_dev.ko.

Initial patch was developed and tested on top of 5.x kernel. I better ask CAN
community if some one has idea on what is going wrong here.

CCing CAN maeling list.

> Here an excerpt (more data at attachment excerpt.txt):
> Jun 24 09:44:01 (none) kernel: [67592.681525] ------------[ cut here ]------------
> Jun 24 09:44:01 (none) kernel: [67592.681539] WARNING: CPU: 2 PID: 0 at /home/buildroot/darthost_APC910_wl/kernel/linux-4.19.237/net/core/skbuff.c:624 skb_release_head_state+0x55/0x60
> Jun 24 09:44:01 (none) kernel: [67592.681540] Modules linked in: elo cc770_isa cc770 can_dev can_raw can e1000e pl2303 usbserial ptp pps_core x86_pkg_temp_thermal
> Jun 24 09:44:01 (none) kernel: [67592.681545] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G        W         4.19.237_dev-tomoyo-ima #1
> Jun 24 09:44:01 (none) kernel: [67592.681546] Hardware name: Bernecker + Rainer  Industrie-Elektronik  APC910/TS170, BIOS W1.22 02/03/2022
> Jun 24 09:44:01 (none) kernel: [67592.681549] RIP: 0010:skb_release_head_state+0x55/0x60
> Jun 24 09:44:01 (none) kernel: [67592.681550] Code: 81 e2 00 00 0f 00 75 16 48 89 df 5b e9 a4 f9 31 00 5b c3 48 83 e7 fe e8 f9 ff 01 00 eb ca 48 c7 c7 68 57 d8 81 e8 28 8e 0e 00 <0f> 0b 48 8b 43 60 eb d6 0f 1f 00 53 48 89 fb e8 97 ff ff ff 48 83
> Jun 24 09:44:01 (none) kernel: [67592.681552] RSP: 0018:ffff888267b03e78 EFLAGS: 00010086
> Jun 24 09:44:01 (none) kernel: [67592.681553] RAX: 0000000000000024 RBX: ffff8881fdc7e100 RCX: ffffffff82035638
> Jun 24 09:44:01 (none) kernel: [67592.681554] RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffffffff825587ac
> Jun 24 09:44:01 (none) kernel: [67592.681555] RBP: 0000000000000000 R08: 0000000000e992c4 R09: 0000000000000007
> Jun 24 09:44:01 (none) kernel: [67592.681556] R10: 0000000000000000 R11: ffffffff8255a7ed R12: ffff888266a7e000
> Jun 24 09:44:01 (none) kernel: [67592.681557] R13: ffff888246313500 R14: ffff888266a7e000 R15: 0000000000000055
> Jun 24 09:44:01 (none) kernel: [67592.681558] FS:  0000000000000000(0000) GS:ffff888267b00000(0000) knlGS:0000000000000000
> Jun 24 09:44:01 (none) kernel: [67592.681559] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jun 24 09:44:01 (none) kernel: [67592.681560] CR2: 0000000000000000 CR3: 000000000200a001 CR4: 00000000003606e0
> Jun 24 09:44:01 (none) kernel: [67592.681561] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Jun 24 09:44:01 (none) kernel: [67592.681562] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Jun 24 09:44:01 (none) kernel: [67592.681562] Call Trace:
> Jun 24 09:44:01 (none) kernel: [67592.681564]  <IRQ>
> Jun 24 09:44:01 (none) kernel: [67592.681567]  skb_release_all+0x9/0x20
> Jun 24 09:44:01 (none) kernel: [67592.681568]  consume_skb+0x27/0x90
> Jun 24 09:44:01 (none) kernel: [67592.681571]  can_put_echo_skb+0xc5/0x120 [can_dev]
> Jun 24 09:44:01 (none) kernel: [67592.681573]  cc770_interrupt+0x220/0x600 [cc770]
> Jun 24 09:44:01 (none) kernel: [67592.681575]  ? timerqueue_add+0x58/0x60
> Jun 24 09:44:01 (none) kernel: [67592.681578]  __handle_irq_event_percpu+0x41/0x1a0
> Jun 24 09:44:01 (none) kernel: [67592.681580]  handle_irq_event_percpu+0x2b/0x70
> Jun 24 09:44:01 (none) kernel: [67592.681582]  handle_irq_event+0x22/0x40
> Jun 24 09:44:01 (none) kernel: [67592.681584]  handle_edge_irq+0x75/0x190
> Jun 24 09:44:01 (none) kernel: [67592.681586]  handle_irq+0x17/0x20
> Jun 24 09:44:01 (none) kernel: [67592.681588]  do_IRQ+0x3c/0xd0
> Jun 24 09:44:01 (none) kernel: [67592.681590]  common_interrupt+0xf/0xf
> Jun 24 09:44:01 (none) kernel: [67592.681591]  </IRQ>
> Jun 24 09:44:01 (none) kernel: [67592.681594] RIP: 0010:cpuidle_enter_state+0xb2/0x310
> Jun 24 09:44:01 (none) kernel: [67592.681595] Code: c3 8b 05 99 31 a4 00 85 c0 0f 8f 33 01 00 00 31 ff e8 c2 06 9e ff 45 84 f6 0f 85 f1 00 00 00 fb 48 ba cf f7 53 e3 a5 9b c4 20 <4c> 29 fb 48 89 d8 48 c1 fb 3f 48 f7 ea b8 ff ff ff 7f 48 c1 fa 07
> Jun 24 09:44:01 (none) kernel: [67592.681596] RSP: 0018:ffffc900000a7e90 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffdc
> Jun 24 09:44:01 (none) kernel: [67592.681598] RAX: ffff888267b24840 RBX: 00003d79a5c4f930 RCX: 000000000000001f
> Jun 24 09:44:01 (none) kernel: [67592.681599] RDX: 20c49ba5e353f7cf RSI: 000000002f32988b RDI: 0000000000000000
> Jun 24 09:44:01 (none) kernel: [67592.681600] RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000024100
> Jun 24 09:44:01 (none) kernel: [67592.681601] R10: ffffc900000a7e78 R11: 0000000000003cc2 R12: ffffffff82091878
> Jun 24 09:44:01 (none) kernel: [67592.681601] R13: ffff888267b2be00 R14: 0000000000000000 R15: 00003d79a5b3bdb2
> Jun 24 09:44:01 (none) kernel: [67592.681605]  do_idle+0x1d6/0x230
> Jun 24 09:44:01 (none) kernel: [67592.681607]  cpu_startup_entry+0x6a/0x70
> Jun 24 09:44:01 (none) kernel: [67592.681610]  start_secondary+0x183/0x1b0
> Jun 24 09:44:01 (none) kernel: [67592.681611]  secondary_startup_64+0xa4/0xb0
> Jun 24 09:44:01 (none) kernel: [67592.681613] ---[ end trace 7155571a10d3a959 ]---
> 
> As the kernel logs are redirected to a file at my system, the disk is running out of space after some time.
> 
> Another user, Patric Hopfgarten, has reported the same error at this post:
> https://bugs.launchpad.net/ubuntu/+source/linux-signed-hwe/+bug/1915035
> 
> After some research I discovered the change made at commit ef02687fc78099ef3fd2eb8a150c2823fe2d9061:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/include/linux/can?h=linux-4.19.y&id=ef02687fc78099ef3fd2eb8a150c2823fe2d9061
> 
> For testing purposes I reverted only this commit at kernel version 4.19.237 and all the logging problems disappeared.
> 
> I think the original reason:
> "... The problem shows up in the j1939 stack, when it clones the incoming skb, which
> detects the already 0 refcount. ..."
> for that commit is not valid for kernel version 4.19.237 as this version does not support the j1939 stack at mainline.
> 
> What solution can you imagine for solving the described problem?
> 
> Looking forward to get your feedback.
> 
> 
> Kind regards
> 
> Michael Käsbauer
> Software Developer of Sensor Technology
> CRD Inspection Technology
> 
> Krones AG
> Böhmerwaldstraße 5
> 93073 Neutraubling
> Germany
> 
> Phone: +49 (0)9401 70-1853
> E-Mail: michael.kaesbauer@krones.com<mailto:michael.kaesbauer@krones.com>
> Internet: www.krones.com<http://www.krones.com>
> 
> 
> [https://www.krones.com/ext/mailbanner/drinktec/Krones_Linie_Mann.jpg] <https://www.krones.com/drinktec> ______________________________________________________________
> 
> Krones AG
> Vorstand: Christoph Klenk, Vorstandsvorsitzender,
> Norbert Broger, Thomas Ricker, Markus Tischer, Ralf Goldbrunner
> Vorsitzender des Aufsichtsrats: Volker Kronseder
> Registergericht: Regensburg HRB 23 44, Umsatzsteuer-ID-Nummer: DE 133 695 999
> 
> ______________________________________________________________
> 
> Der Inhalt dieser E-Mail und jeder Anhang ist vertraulich.
> Diese Inhalte sind nur fuer die benannten Adressaten.
> Wenn Sie diese E-Mail durch einen Fehler erhalten haben,
> benachrichtigen Sie sofort Ihren Administrator oder den Absender.
> Behandeln Sie die E-Mail vertraulich.
> 
> * Diese E-Mail wurde auf Viren und gefaehrlichen Inhalt geprueft. *
> 
> ______________________________________________________________
> 
> The contents of this email and any attachments are confidential.
> They are intended for the named recipient(s) only.
> If you have received this email in error please notify the system manager
> or the sender immediately and do not disclose the contents to anyone or
> make copies.
> 
> * This e-Mail was scanned for viruses, vandals and malicious content. *

> ...
> Jun 24 09:44:01 (none) kernel: [67592.681525] ------------[ cut here ]------------
> Jun 24 09:44:01 (none) kernel: [67592.681539] WARNING: CPU: 2 PID: 0 at /home/buildroot/darthost_APC910_wl/kernel/linux-4.19.237/net/core/skbuff.c:624 skb_release_head_state+0x55/0x60
> Jun 24 09:44:01 (none) kernel: [67592.681540] Modules linked in: elo cc770_isa cc770 can_dev can_raw can e1000e pl2303 usbserial ptp pps_core x86_pkg_temp_thermal
> Jun 24 09:44:01 (none) kernel: [67592.681545] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G        W         4.19.237_dev-tomoyo-ima #1
> Jun 24 09:44:01 (none) kernel: [67592.681546] Hardware name: Bernecker + Rainer  Industrie-Elektronik  APC910/TS170, BIOS W1.22 02/03/2022
> Jun 24 09:44:01 (none) kernel: [67592.681549] RIP: 0010:skb_release_head_state+0x55/0x60
> Jun 24 09:44:01 (none) kernel: [67592.681550] Code: 81 e2 00 00 0f 00 75 16 48 89 df 5b e9 a4 f9 31 00 5b c3 48 83 e7 fe e8 f9 ff 01 00 eb ca 48 c7 c7 68 57 d8 81 e8 28 8e 0e 00 <0f> 0b 48 8b 43 60 eb d6 0f 1f 00 53 48 89 fb e8 97 ff ff ff 48 83
> Jun 24 09:44:01 (none) kernel: [67592.681552] RSP: 0018:ffff888267b03e78 EFLAGS: 00010086
> Jun 24 09:44:01 (none) kernel: [67592.681553] RAX: 0000000000000024 RBX: ffff8881fdc7e100 RCX: ffffffff82035638
> Jun 24 09:44:01 (none) kernel: [67592.681554] RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffffffff825587ac
> Jun 24 09:44:01 (none) kernel: [67592.681555] RBP: 0000000000000000 R08: 0000000000e992c4 R09: 0000000000000007
> Jun 24 09:44:01 (none) kernel: [67592.681556] R10: 0000000000000000 R11: ffffffff8255a7ed R12: ffff888266a7e000
> Jun 24 09:44:01 (none) kernel: [67592.681557] R13: ffff888246313500 R14: ffff888266a7e000 R15: 0000000000000055
> Jun 24 09:44:01 (none) kernel: [67592.681558] FS:  0000000000000000(0000) GS:ffff888267b00000(0000) knlGS:0000000000000000
> Jun 24 09:44:01 (none) kernel: [67592.681559] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jun 24 09:44:01 (none) kernel: [67592.681560] CR2: 0000000000000000 CR3: 000000000200a001 CR4: 00000000003606e0
> Jun 24 09:44:01 (none) kernel: [67592.681561] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Jun 24 09:44:01 (none) kernel: [67592.681562] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Jun 24 09:44:01 (none) kernel: [67592.681562] Call Trace:
> Jun 24 09:44:01 (none) kernel: [67592.681564]  <IRQ>
> Jun 24 09:44:01 (none) kernel: [67592.681567]  skb_release_all+0x9/0x20
> Jun 24 09:44:01 (none) kernel: [67592.681568]  consume_skb+0x27/0x90
> Jun 24 09:44:01 (none) kernel: [67592.681571]  can_put_echo_skb+0xc5/0x120 [can_dev]
> Jun 24 09:44:01 (none) kernel: [67592.681573]  cc770_interrupt+0x220/0x600 [cc770]
> Jun 24 09:44:01 (none) kernel: [67592.681575]  ? timerqueue_add+0x58/0x60
> Jun 24 09:44:01 (none) kernel: [67592.681578]  __handle_irq_event_percpu+0x41/0x1a0
> Jun 24 09:44:01 (none) kernel: [67592.681580]  handle_irq_event_percpu+0x2b/0x70
> Jun 24 09:44:01 (none) kernel: [67592.681582]  handle_irq_event+0x22/0x40
> Jun 24 09:44:01 (none) kernel: [67592.681584]  handle_edge_irq+0x75/0x190
> Jun 24 09:44:01 (none) kernel: [67592.681586]  handle_irq+0x17/0x20
> Jun 24 09:44:01 (none) kernel: [67592.681588]  do_IRQ+0x3c/0xd0
> Jun 24 09:44:01 (none) kernel: [67592.681590]  common_interrupt+0xf/0xf
> Jun 24 09:44:01 (none) kernel: [67592.681591]  </IRQ>
> Jun 24 09:44:01 (none) kernel: [67592.681594] RIP: 0010:cpuidle_enter_state+0xb2/0x310
> Jun 24 09:44:01 (none) kernel: [67592.681595] Code: c3 8b 05 99 31 a4 00 85 c0 0f 8f 33 01 00 00 31 ff e8 c2 06 9e ff 45 84 f6 0f 85 f1 00 00 00 fb 48 ba cf f7 53 e3 a5 9b c4 20 <4c> 29 fb 48 89 d8 48 c1 fb 3f 48 f7 ea b8 ff ff ff 7f 48 c1 fa 07
> Jun 24 09:44:01 (none) kernel: [67592.681596] RSP: 0018:ffffc900000a7e90 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffdc
> Jun 24 09:44:01 (none) kernel: [67592.681598] RAX: ffff888267b24840 RBX: 00003d79a5c4f930 RCX: 000000000000001f
> Jun 24 09:44:01 (none) kernel: [67592.681599] RDX: 20c49ba5e353f7cf RSI: 000000002f32988b RDI: 0000000000000000
> Jun 24 09:44:01 (none) kernel: [67592.681600] RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000024100
> Jun 24 09:44:01 (none) kernel: [67592.681601] R10: ffffc900000a7e78 R11: 0000000000003cc2 R12: ffffffff82091878
> Jun 24 09:44:01 (none) kernel: [67592.681601] R13: ffff888267b2be00 R14: 0000000000000000 R15: 00003d79a5b3bdb2
> Jun 24 09:44:01 (none) kernel: [67592.681605]  do_idle+0x1d6/0x230
> Jun 24 09:44:01 (none) kernel: [67592.681607]  cpu_startup_entry+0x6a/0x70
> Jun 24 09:44:01 (none) kernel: [67592.681610]  start_secondary+0x183/0x1b0
> Jun 24 09:44:01 (none) kernel: [67592.681611]  secondary_startup_64+0xa4/0xb0
> Jun 24 09:44:01 (none) kernel: [67592.681613] ---[ end trace 7155571a10d3a959 ]---
> Jun 24 09:44:01 (none) kernel: [67593.322902] ------------[ cut here ]------------
> Jun 24 09:44:01 (none) kernel: [67593.322916] WARNING: CPU: 2 PID: 0 at /home/buildroot/darthost_APC910_wl/kernel/linux-4.19.237/net/core/skbuff.c:624 skb_release_head_state+0x55/0x60
> Jun 24 09:44:01 (none) kernel: [67593.322917] Modules linked in: elo cc770_isa cc770 can_dev can_raw can e1000e pl2303 usbserial ptp pps_core x86_pkg_temp_thermal
> Jun 24 09:44:01 (none) kernel: [67593.322922] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G        W         4.19.237_dev-tomoyo-ima #1
> Jun 24 09:44:01 (none) kernel: [67593.322923] Hardware name: Bernecker + Rainer  Industrie-Elektronik  APC910/TS170, BIOS W1.22 02/03/2022
> Jun 24 09:44:01 (none) kernel: [67593.322926] RIP: 0010:skb_release_head_state+0x55/0x60
> Jun 24 09:44:01 (none) kernel: [67593.322927] Code: 81 e2 00 00 0f 00 75 16 48 89 df 5b e9 a4 f9 31 00 5b c3 48 83 e7 fe e8 f9 ff 01 00 eb ca 48 c7 c7 68 57 d8 81 e8 28 8e 0e 00 <0f> 0b 48 8b 43 60 eb d6 0f 1f 00 53 48 89 fb e8 97 ff ff ff 48 83
> Jun 24 09:44:01 (none) kernel: [67593.322928] RSP: 0018:ffff888267b03e78 EFLAGS: 00010086
> Jun 24 09:44:01 (none) kernel: [67593.322930] RAX: 0000000000000024 RBX: ffff888246313400 RCX: ffffffff82035638
> Jun 24 09:44:01 (none) kernel: [67593.322931] RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffffffff825587ac
> Jun 24 09:44:01 (none) kernel: [67593.322932] RBP: 0000000000000000 R08: 0000000000e992f2 R09: 0000000000000007
> Jun 24 09:44:01 (none) kernel: [67593.322933] R10: 0000000000000000 R11: ffffffff8255a7ed R12: ffff888266a7e000
> Jun 24 09:44:01 (none) kernel: [67593.322934] R13: ffff888246313300 R14: ffff888266a7e000 R15: 0000000000000055
> Jun 24 09:44:01 (none) kernel: [67593.322935] FS:  0000000000000000(0000) GS:ffff888267b00000(0000) knlGS:0000000000000000
> Jun 24 09:44:01 (none) kernel: [67593.322936] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jun 24 09:44:01 (none) kernel: [67593.322937] CR2: 00007f7fd9d60008 CR3: 000000000200a002 CR4: 00000000003606e0
> Jun 24 09:44:01 (none) kernel: [67593.322938] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Jun 24 09:44:01 (none) kernel: [67593.322939] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Jun 24 09:44:01 (none) kernel: [67593.322939] Call Trace:
> Jun 24 09:44:01 (none) kernel: [67593.322941]  <IRQ>
> Jun 24 09:44:01 (none) kernel: [67593.322944]  skb_release_all+0x9/0x20
> Jun 24 09:44:01 (none) kernel: [67593.322945]  consume_skb+0x27/0x90
> Jun 24 09:44:01 (none) kernel: [67593.322948]  can_put_echo_skb+0xc5/0x120 [can_dev]
> Jun 24 09:44:01 (none) kernel: [67593.322950]  cc770_interrupt+0x220/0x600 [cc770]
> Jun 24 09:44:01 (none) kernel: [67593.322954]  __handle_irq_event_percpu+0x41/0x1a0
> Jun 24 09:44:01 (none) kernel: [67593.322956]  handle_irq_event_percpu+0x2b/0x70
> Jun 24 09:44:01 (none) kernel: [67593.322958]  handle_irq_event+0x22/0x40
> Jun 24 09:44:01 (none) kernel: [67593.322960]  handle_edge_irq+0x75/0x190
> Jun 24 09:44:01 (none) kernel: [67593.322961]  handle_irq+0x17/0x20
> Jun 24 09:44:01 (none) kernel: [67593.322963]  do_IRQ+0x3c/0xd0
> Jun 24 09:44:01 (none) kernel: [67593.322966]  common_interrupt+0xf/0xf
> Jun 24 09:44:01 (none) kernel: [67593.322967]  </IRQ>
> Jun 24 09:44:01 (none) kernel: [67593.322970] RIP: 0010:cpuidle_enter_state+0xb2/0x310
> Jun 24 09:44:01 (none) kernel: [67593.322971] Code: c3 8b 05 99 31 a4 00 85 c0 0f 8f 33 01 00 00 31 ff e8 c2 06 9e ff 45 84 f6 0f 85 f1 00 00 00 fb 48 ba cf f7 53 e3 a5 9b c4 20 <4c> 29 fb 48 89 d8 48 c1 fb 3f 48 f7 ea b8 ff ff ff 7f 48 c1 fa 07
> Jun 24 09:44:01 (none) kernel: [67593.322972] RSP: 0018:ffffc900000a7e90 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffdc
> Jun 24 09:44:01 (none) kernel: [67593.322973] RAX: ffff888267b24840 RBX: 00003d79cbff9cb5 RCX: 000000000000001f
> Jun 24 09:44:01 (none) kernel: [67593.322974] RDX: 20c49ba5e353f7cf RSI: 000000002f32988b RDI: 0000000000000000
> Jun 24 09:44:01 (none) kernel: [67593.322975] RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000024100
> Jun 24 09:44:01 (none) kernel: [67593.322976] R10: ffffc900000a7e78 R11: 0000000000000201 R12: ffffffff82091878
> Jun 24 09:44:01 (none) kernel: [67593.322977] R13: ffff888267b2be00 R14: 0000000000000000 R15: 00003d79cbfb62b3
> Jun 24 09:44:01 (none) kernel: [67593.322980]  do_idle+0x1d6/0x230
> Jun 24 09:44:01 (none) kernel: [67593.322983]  cpu_startup_entry+0x6a/0x70
> Jun 24 09:44:01 (none) kernel: [67593.322985]  start_secondary+0x183/0x1b0
> Jun 24 09:44:01 (none) kernel: [67593.322987]  secondary_startup_64+0xa4/0xb0
> Jun 24 09:44:01 (none) kernel: [67593.322988] ---[ end trace 7155571a10d3a95a ]---
> Jun 24 09:44:01 (none) kernel: [67593.343772] ------------[ cut here ]------------
> Jun 24 09:44:01 (none) kernel: [67593.343782] WARNING: CPU: 2 PID: 0 at /home/buildroot/darthost_APC910_wl/kernel/linux-4.19.237/net/core/skbuff.c:624 skb_release_head_state+0x55/0x60
> Jun 24 09:44:01 (none) kernel: [67593.343783] Modules linked in: elo cc770_isa cc770 can_dev can_raw can e1000e pl2303 usbserial ptp pps_core x86_pkg_temp_thermal
> Jun 24 09:44:01 (none) kernel: [67593.343788] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G        W         4.19.237_dev-tomoyo-ima #1
> Jun 24 09:44:01 (none) kernel: [67593.343789] Hardware name: Bernecker + Rainer  Industrie-Elektronik  APC910/TS170, BIOS W1.22 02/03/2022
> Jun 24 09:44:01 (none) kernel: [67593.343791] RIP: 0010:skb_release_head_state+0x55/0x60
> Jun 24 09:44:01 (none) kernel: [67593.343793] Code: 81 e2 00 00 0f 00 75 16 48 89 df 5b e9 a4 f9 31 00 5b c3 48 83 e7 fe e8 f9 ff 01 00 eb ca 48 c7 c7 68 57 d8 81 e8 28 8e 0e 00 <0f> 0b 48 8b 43 60 eb d6 0f 1f 00 53 48 89 fb e8 97 ff ff ff 48 83
> Jun 24 09:44:01 (none) kernel: [67593.343794] RSP: 0018:ffff888267b03e78 EFLAGS: 00010086
> Jun 24 09:44:01 (none) kernel: [67593.343795] RAX: 0000000000000024 RBX: ffff8881fdc7e100 RCX: ffffffff82035638
> Jun 24 09:44:01 (none) kernel: [67593.343796] RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffffffff825587ac
> Jun 24 09:44:01 (none) kernel: [67593.343797] RBP: 0000000000000000 R08: 0000000000e9931f R09: 0000000000000007
> Jun 24 09:44:01 (none) kernel: [67593.343798] R10: 0000000000000000 R11: ffffffff8255a7ed R12: ffff888266a7e000
> Jun 24 09:44:01 (none) kernel: [67593.343799] R13: ffff888246313400 R14: ffff888266a7e000 R15: 0000000000000055
> Jun 24 09:44:01 (none) kernel: [67593.343800] FS:  0000000000000000(0000) GS:ffff888267b00000(0000) knlGS:0000000000000000
> Jun 24 09:44:01 (none) kernel: [67593.343801] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jun 24 09:44:01 (none) kernel: [67593.343802] CR2: 00007f7fd9d60008 CR3: 000000000200a002 CR4: 00000000003606e0
> Jun 24 09:44:01 (none) kernel: [67593.343803] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Jun 24 09:44:01 (none) kernel: [67593.343804] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Jun 24 09:44:01 (none) kernel: [67593.343805] Call Trace:
> Jun 24 09:44:01 (none) kernel: [67593.343806]  <IRQ>
> Jun 24 09:44:01 (none) kernel: [67593.343808]  skb_release_all+0x9/0x20
> Jun 24 09:44:01 (none) kernel: [67593.343810]  consume_skb+0x27/0x90
> Jun 24 09:44:01 (none) kernel: [67593.343812]  can_put_echo_skb+0xc5/0x120 [can_dev]
> Jun 24 09:44:01 (none) kernel: [67593.343814]  cc770_interrupt+0x220/0x600 [cc770]
> Jun 24 09:44:01 (none) kernel: [67593.343816]  ? timerqueue_add+0x58/0x60
> Jun 24 09:44:01 (none) kernel: [67593.343819]  __handle_irq_event_percpu+0x41/0x1a0
> Jun 24 09:44:01 (none) kernel: [67593.343821]  handle_irq_event_percpu+0x2b/0x70
> Jun 24 09:44:01 (none) kernel: [67593.343823]  handle_irq_event+0x22/0x40
> Jun 24 09:44:01 (none) kernel: [67593.343824]  handle_edge_irq+0x75/0x190
> Jun 24 09:44:01 (none) kernel: [67593.343826]  handle_irq+0x17/0x20
> Jun 24 09:44:01 (none) kernel: [67593.343827]  do_IRQ+0x3c/0xd0
> Jun 24 09:44:01 (none) kernel: [67593.343830]  common_interrupt+0xf/0xf
> Jun 24 09:44:01 (none) kernel: [67593.343831]  </IRQ>
> Jun 24 09:44:01 (none) kernel: [67593.343833] RIP: 0010:cpuidle_enter_state+0xb2/0x310
> Jun 24 09:44:01 (none) kernel: [67593.343835] Code: c3 8b 05 99 31 a4 00 85 c0 0f 8f 33 01 00 00 31 ff e8 c2 06 9e ff 45 84 f6 0f 85 f1 00 00 00 fb 48 ba cf f7 53 e3 a5 9b c4 20 <4c> 29 fb 48 89 d8 48 c1 fb 3f 48 f7 ea b8 ff ff ff 7f 48 c1 fa 07
> Jun 24 09:44:01 (none) kernel: [67593.343836] RSP: 0018:ffffc900000a7e90 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffdc
> Jun 24 09:44:01 (none) kernel: [67593.343837] RAX: ffff888267b24840 RBX: 00003d79cd3e5ff2 RCX: 000000000000001f
> Jun 24 09:44:01 (none) kernel: [67593.343838] RDX: 20c49ba5e353f7cf RSI: 000000002f32988b RDI: 0000000000000000
> Jun 24 09:44:01 (none) kernel: [67593.343839] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000024100
> Jun 24 09:44:01 (none) kernel: [67593.343840] R10: ffffc900000a7e78 R11: 0000000000003d3d R12: ffffffff82091638
> Jun 24 09:44:01 (none) kernel: [67593.343841] R13: ffff888267b2be00 R14: 0000000000000000 R15: 00003d79cd385aa1
> Jun 24 09:44:01 (none) kernel: [67593.343844]  do_idle+0x1d6/0x230
> Jun 24 09:44:01 (none) kernel: [67593.343846]  cpu_startup_entry+0x6a/0x70
> Jun 24 09:44:01 (none) kernel: [67593.343848]  start_secondary+0x183/0x1b0
> Jun 24 09:44:01 (none) kernel: [67593.343849]  secondary_startup_64+0xa4/0xb0
> Jun 24 09:44:01 (none) kernel: [67593.343851] ---[ end trace 7155571a10d3a95b ]---
> Jun 24 09:44:02 (none) kernel: [67593.345557] ------------[ cut here ]------------
> Jun 24 09:44:02 (none) kernel: [67593.345566] WARNING: CPU: 2 PID: 0 at /home/buildroot/darthost_APC910_wl/kernel/linux-4.19.237/net/core/skbuff.c:624 skb_release_head_state+0x55/0x60
> Jun 24 09:44:02 (none) kernel: [67593.345567] Modules linked in: elo cc770_isa cc770 can_dev can_raw can e1000e pl2303 usbserial ptp pps_core x86_pkg_temp_thermal
> Jun 24 09:44:02 (none) kernel: [67593.345571] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G        W         4.19.237_dev-tomoyo-ima #1
> Jun 24 09:44:02 (none) kernel: [67593.345572] Hardware name: Bernecker + Rainer  Industrie-Elektronik  APC910/TS170, BIOS W1.22 02/03/2022
> Jun 24 09:44:02 (none) kernel: [67593.345574] RIP: 0010:skb_release_head_state+0x55/0x60
> Jun 24 09:44:02 (none) kernel: [67593.345576] Code: 81 e2 00 00 0f 00 75 16 48 89 df 5b e9 a4 f9 31 00 5b c3 48 83 e7 fe e8 f9 ff 01 00 eb ca 48 c7 c7 68 57 d8 81 e8 28 8e 0e 00 <0f> 0b 48 8b 43 60 eb d6 0f 1f 00 53 48 89 fb e8 97 ff ff ff 48 83
> Jun 24 09:44:02 (none) kernel: [67593.345577] RSP: 0018:ffff888267b03e78 EFLAGS: 00010086
> Jun 24 09:44:02 (none) kernel: [67593.345578] RAX: 0000000000000024 RBX: ffff888246313400 RCX: ffffffff82035638
> Jun 24 09:44:02 (none) kernel: [67593.345579] RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffffffff825587ac
> Jun 24 09:44:02 (none) kernel: [67593.345580] RBP: 0000000000000000 R08: 0000000000e9934d R09: 0000000000000007
> Jun 24 09:44:02 (none) kernel: [67593.345581] R10: 0000000000000000 R11: ffffffff8255a7ed R12: ffff888266a7e000
> Jun 24 09:44:02 (none) kernel: [67593.345582] R13: ffff888246313100 R14: ffff888266a7e000 R15: 0000000000000055
> Jun 24 09:44:02 (none) kernel: [67593.345583] FS:  0000000000000000(0000) GS:ffff888267b00000(0000) knlGS:0000000000000000
> Jun 24 09:44:02 (none) kernel: [67593.345584] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jun 24 09:44:02 (none) kernel: [67593.345585] CR2: 00007f7fd9d60008 CR3: 000000000200a002 CR4: 00000000003606e0
> Jun 24 09:44:02 (none) kernel: [67593.345586] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Jun 24 09:44:02 (none) kernel: [67593.345587] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Jun 24 09:44:02 (none) kernel: [67593.345588] Call Trace:
> Jun 24 09:44:02 (none) kernel: [67593.345589]  <IRQ>
> Jun 24 09:44:02 (none) kernel: [67593.345591]  skb_release_all+0x9/0x20
> Jun 24 09:44:02 (none) kernel: [67593.345593]  consume_skb+0x27/0x90
> Jun 24 09:44:02 (none) kernel: [67593.345595]  can_put_echo_skb+0xc5/0x120 [can_dev]
> Jun 24 09:44:02 (none) kernel: [67593.345597]  cc770_interrupt+0x220/0x600 [cc770]
> Jun 24 09:44:02 (none) kernel: [67593.345599]  ? timerqueue_add+0x58/0x60
> Jun 24 09:44:02 (none) kernel: [67593.345601]  __handle_irq_event_percpu+0x41/0x1a0
> Jun 24 09:44:02 (none) kernel: [67593.345603]  handle_irq_event_percpu+0x2b/0x70
> Jun 24 09:44:02 (none) kernel: [67593.345605]  handle_irq_event+0x22/0x40
> Jun 24 09:44:02 (none) kernel: [67593.345607]  handle_edge_irq+0x75/0x190
> Jun 24 09:44:02 (none) kernel: [67593.345608]  handle_irq+0x17/0x20
> Jun 24 09:44:02 (none) kernel: [67593.345609]  do_IRQ+0x3c/0xd0
> Jun 24 09:44:02 (none) kernel: [67593.345612]  common_interrupt+0xf/0xf
> Jun 24 09:44:02 (none) kernel: [67593.345613]  </IRQ>
> Jun 24 09:44:02 (none) kernel: [67593.345615] RIP: 0010:cpuidle_enter_state+0xb2/0x310
> Jun 24 09:44:02 (none) kernel: [67593.345616] Code: c3 8b 05 99 31 a4 00 85 c0 0f 8f 33 01 00 00 31 ff e8 c2 06 9e ff 45 84 f6 0f 85 f1 00 00 00 fb 48 ba cf f7 53 e3 a5 9b c4 20 <4c> 29 fb 48 89 d8 48 c1 fb 3f 48 f7 ea b8 ff ff ff 7f 48 c1 fa 07
> Jun 24 09:44:02 (none) kernel: [67593.345617] RSP: 0018:ffffc900000a7e90 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffdc
> Jun 24 09:44:02 (none) kernel: [67593.345619] RAX: ffff888267b24840 RBX: 00003d79cd595186 RCX: 000000000000001f
> Jun 24 09:44:02 (none) kernel: [67593.345619] RDX: 20c49ba5e353f7cf RSI: 000000002f32988b RDI: 0000000000000000
> Jun 24 09:44:02 (none) kernel: [67593.345620] RBP: 0000000000000006 R08: 0000000000000000 R09: 0000000000024100
> Jun 24 09:44:02 (none) kernel: [67593.345621] R10: ffffc900000a7e78 R11: 0000000000000225 R12: ffffffff820917b8
> Jun 24 09:44:02 (none) kernel: [67593.345622] R13: ffff888267b2be00 R14: 0000000000000000 R15: 00003d79cd56dc90
> Jun 24 09:44:02 (none) kernel: [67593.345625]  do_idle+0x1d6/0x230
> Jun 24 09:44:02 (none) kernel: [67593.345627]  cpu_startup_entry+0x6a/0x70
> Jun 24 09:44:02 (none) kernel: [67593.345629]  start_secondary+0x183/0x1b0
> Jun 24 09:44:02 (none) kernel: [67593.345631]  secondary_startup_64+0xa4/0xb0
> Jun 24 09:44:02 (none) kernel: [67593.345632] ---[ end trace 7155571a10d3a95c ]---
> ...


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

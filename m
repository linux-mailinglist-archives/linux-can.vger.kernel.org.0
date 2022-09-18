Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C15B5BC03F
	for <lists+linux-can@lfdr.de>; Mon, 19 Sep 2022 00:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiIRWBp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 18 Sep 2022 18:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiIRWBo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 18 Sep 2022 18:01:44 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Sep 2022 15:01:43 PDT
Received: from mail2-emea.wika.com (mail2-emea.wika.com [195.145.204.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474C615812
        for <linux-can@vger.kernel.org>; Sun, 18 Sep 2022 15:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=wika.com; i=@wika.com; q=dns/txt; s=wika1;
  t=1663538503;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vLt+FPV+PLc/5cIQ3S/HzcdwG7rgCjluPV8pUB9dTUs=;
  b=b3QtnVnIbaigCNWkU+0jUZ5tsFkm9/0gVzQFVIRsD6CVLQUTzKcuzmhP
   aH4iz9hz5Tt8kW+gjZNWnJELQlla7+ywoVO6jdQK5JbXXfaFvMotBGkE8
   paDFj19Xa9Eqh/MFf1Aw7RSQEvz/dyqmezy45A1CNoWCbY7CnOlIFk/7u
   WmleNt7syQiSx3OM/gdNJtiPn+UqfUQUhMozE2l2xvCIsb7vDo2KyeUho
   VD0ZB5d6HB/pCR5FHm7dZRsPnuwCY8po5fwvuMJ2m9bwtABhrWBlyoNOQ
   7BJxVhnbKngFdOW+t9hxuJTFXq9uWaqahZXiJAAtqXhjTBgxznhJilrJC
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,325,1654552800"; 
   d="scan'208";a="23234913"
Received: from unknown (HELO USATL1S6503.corp.root.int) ([172.17.4.223])
  by mail2-emea.wika.com with ESMTP/TLS/ECDHE-RSA-AES128-SHA; 19 Sep 2022 00:00:38 +0200
Received: from USATL1S6502.corp.root.int (172.17.4.222) by
 USATL1S6503.corp.root.int (172.17.4.223) with Microsoft SMTP Server
 (version=TLS1_1, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA_P256) id
 15.1.2507.9; Sun, 18 Sep 2022 18:00:35 -0400
Received: from USATL1S6502.corp.root.int ([fe80::25de:b226:769c:6e35]) by
 USATL1S6502.corp.root.int ([fe80::25de:b226:769c:6e35%12]) with mapi id
 15.01.2507.009; Sun, 18 Sep 2022 18:00:35 -0400
From:   "Trevitz, Daniel" <Daniel.Trevitz@wika.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     Ryan Edwards <ryan.edwards@gmail.com>
Subject: RE: [PATCH v2 0/3] can: gs_usb: cleanups and termination support
Thread-Topic: [PATCH v2 0/3] can: gs_usb: cleanups and termination support
Thread-Index: AQHYy6Qn9lPAAuU5lE2VqezZ2vkkSq3lvDDQ
Date:   Sun, 18 Sep 2022 22:00:35 +0000
Message-ID: <de6f97b076ca4a06862cbb91a50fc718@wika.com>
References: <20220918211802.692405-1-mkl@pengutronix.de>
In-Reply-To: <20220918211802.692405-1-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.6.18]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-GBS-PROC: sA4kpg/r311DIhrlAiub+DgmD5TOi2VkDa//nHEjf1G+hAveAQZLGy1pEJbV5m5a
X-GBS-PROCJOB: ngR0ZUbw9sh0bR6yKRpjeGOhRj7nR4zTVoCsRVYJy9q54vMDKJJcGou1cSLZPzsM
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Is there a place to document this=3F

Example setting termination state:
	on: ip link set dev can0 type can termination 120
	off: ip link set dev can0 type can termination 0

Read the state:
	ip -details link show can0=20

58: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT group de=
fault qlen 10
    link/can  promiscuity 0 minmtu 0 maxmtu 0=20
    can state STOPPED restart-ms 0=20
          gs_usb: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp_inc 1
          termination 120 [ 0, 120
          clock 48000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 g=
so_max_segs 65535 gro_max_size 65536 parentbus usb parentdev 3-12.2:1.0





**CONFIDENTIALITY NOTICE**


This communication, including any attachments, is from WIKA Mobile Contro=
l, LP and contains confidential information intended only for the address=
ee(s). If you are not the intended recipient, any use, dissemination, dis=
tribution or copying of this document or its contents is strictly prohibi=
ted. If you have received this communication in error, please contact the=
 sender by reply e-mail immediately and destroy all copies of the origina=
l message.=20


-----Original Message-----
From: Marc Kleine-Budde <mkl@pengutronix.de>=20
Sent: Sunday, September 18, 2022 5:18 PM
To: linux-can@vger.kernel.org
Cc: Trevitz, Daniel <Daniel.Trevitz@wika.com>; Ryan Edwards <ryan.edwards=
@gmail.com>
Subject: [PATCH v2 0/3] can: gs_usb: cleanups and termination support


Hello,

this series first cleans up the driver a bit and then adds switchable ter=
mination support.

regards,
Marc

changes since v1 https://lore.kernel.org/all/20220918202348.675850-1-mkl@=
pengutronix.de:
- add 1/3: =22can: gs_usb: gs_make_candev(): convert from usb_control_msg=
() to usb_control_msg_recv()=22
  to make error handling easier
- add 2/3: =22can: gs_usb: gs_make_candev(): clean up error handling=22
  which introduces a cleanup label
- move 1/3 to 3/3:
  - fix gs_usb_get_termination(), set term value
  - remove check of termination value from gs_usb_set_termination()
  - check for initial termination in gs_make_candev()

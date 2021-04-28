Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B7736D6B5
	for <lists+linux-can@lfdr.de>; Wed, 28 Apr 2021 13:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhD1Lof (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Apr 2021 07:44:35 -0400
Received: from lissvexedge01.liebherr.com ([193.27.220.105]:63911 "EHLO
        lissvexedge01.liebherr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229591AbhD1Loe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Apr 2021 07:44:34 -0400
DKIM-Signature: v=1; c=relaxed/relaxed; d=liebherr.com; s=key1e; 
 t=1619610228; bh=R1l6MAsDP9dV5O+hY5CP0z4nIlqI7E57ZYntb76P3nQ=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=ed25519-sha256; b=
 KVzfj/1bKFS3P6vOBYv9dzI26ZI5nFI3n7+2E3wwdN7ZZmfQ8PMMxWKIKoTce1LGvG6S+Xg4vO1kLJYiyEaMBg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=liebherr.com; s=key1; t=1619610228; 
 bh=R1l6MAsDP9dV5O+hY5CP0z4nIlqI7E57ZYntb76P3nQ=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=rsa-sha256; b=
 E6dR9K14G9bntcxB9YW27DEtMrt1O+0TWrTFCJ1zkMEBHFXEBSlbrCYyJEek0vcyTBKqo7LQ9a2MkKqZ0LIhiI1bQRyrhU0uYGueMLMBmAKIajNfemYqS0S3BMGBhRURoBlspVTee4E715rgpAM8TXfvzpsZsF3NDkvkuzeKaSk=
From:   "Sottas Guillaume (LMB)" <Guillaume.Sottas@liebherr.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>
CC:     "Sottas Guillaume (LMB)" <Guillaume.Sottas@liebherr.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "socketcan@hartkopp.net" <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: isotp: return -ECOMM on FC timeout on TX path
Thread-Topic: Re: [PATCH] can: isotp: return -ECOMM on FC timeout on TX path
Thread-Index: Adc8IczWtuMgQZGPSVCWltLg6Zj5tQ==
Date:   Wed, 28 Apr 2021 11:43:47 +0000
Message-ID: <7146dee416c049b5a29fd3cca8a1b773@liebherr.com>
Accept-Language: de-DE, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

First of all thank you for your fast reply.

From my point of view, I think it would make sense to return an error to th=
e user when CAN_ISOTP_WAIT_TX_DONE option is set. Otherwise, I don't unders=
tand the use case of this option?
If the CAN_ISOTP_WAIT_TX_DONE option is not set, then not receiving an erro=
r on timeout could be the expected behavior, as the user does not explicitl=
y ask for completion.

Concerning the way of reporting the error, setting the errno would be a nic=
e solution, as it would not require that much modifications. However, as Ma=
rk mentioned, the errno is not set.
I'm not an expert in how this sk_error_report works internally, but I will =
try to get more infos about it.

In both cases, the documentation in the isotp.c (https://elixir.bootlin.com=
/linux/latest/source/net/can/isotp.c#L7) file is not correct, as it is not =
the actual behavior (most likely the expected).
Additionally, I guess the -ETIMEOUT, -EILSEQ, -EBADMSG,... described in the=
 same documentation are most likely not working that way either, but would =
be fixed if the errno is reported correctly.

Best Regards,

Guillaume



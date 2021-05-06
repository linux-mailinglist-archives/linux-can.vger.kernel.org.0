Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC6A375409
	for <lists+linux-can@lfdr.de>; Thu,  6 May 2021 14:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhEFMqj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 May 2021 08:46:39 -0400
Received: from lissvexedge01.liebherr.com ([193.27.220.105]:55718 "EHLO
        lissvexedge01.liebherr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229777AbhEFMqi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 May 2021 08:46:38 -0400
DKIM-Signature: v=1; c=relaxed/relaxed; d=liebherr.com; s=key1e; 
 t=1620305137; bh=DDbEE3ISD6kYL5uL6vDHAYittDeljSl0mWIlmg2zLbc=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=ed25519-sha256; b=
 Ade8kF9mwnFxAtGJjDnNaWk4OLGfKsgEloGNzFzaNP5bWyA2KmHoiNDsXrSnBV3ZfBztAxROtDmLWtYACYlMAQ==
DKIM-Signature: v=1; c=relaxed/relaxed; d=liebherr.com; s=key1; t=1620305137; 
 bh=DDbEE3ISD6kYL5uL6vDHAYittDeljSl0mWIlmg2zLbc=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=rsa-sha256; b=
 Bnd/Xefk8APOfSq7FJsOUEKTomM4qIbstXthBE0KQoJv+n0XpvFBWrX5tjmbmfLldUxIvkCUzf49Ylfb+clIXi3oiFUl2UVuvCaVjBp53+v+2ZN99Z1zPT1Dc1bQWbinz8NK5d9geIdO3Uc7VuRPH1CQ0QCzt1jVPdB0ywU1OkE=
From:   "Sottas Guillaume (LMB)" <Guillaume.Sottas@liebherr.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>
CC:     "Sottas Guillaume (LMB)" <Guillaume.Sottas@liebherr.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "socketcan@hartkopp.net" <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: isotp: return -ECOMM on FC timeout on TX path
Thread-Topic: Re: [PATCH] can: isotp: return -ECOMM on FC timeout on TX path
Thread-Index: AddCdVtpMbIHBJ+6TKymo6X/494L9w==
Date:   Thu, 6 May 2021 12:45:38 +0000
Message-ID: <b70da5bc15974457b172794ef1149a99@liebherr.com>
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

Hello Marc,

Thank you for your investigations, seems to be the way to go? What is the n=
ext step, could I help in any way or are you going to merge your patch dire=
ctly?
I'm not really sure how we should go further in order to inegrate your fix =
in the code...

Thank you in advance for your feedback,

Best Regards,

Guillaume


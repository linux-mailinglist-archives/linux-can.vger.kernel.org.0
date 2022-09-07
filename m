Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9C55B09AC
	for <lists+linux-can@lfdr.de>; Wed,  7 Sep 2022 18:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiIGQFe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 7 Sep 2022 12:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiIGQFI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Sep 2022 12:05:08 -0400
X-Greylist: delayed 31819 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Sep 2022 09:03:37 PDT
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088F515718
        for <linux-can@vger.kernel.org>; Wed,  7 Sep 2022 09:03:36 -0700 (PDT)
Date:   Wed, 07 Sep 2022 16:03:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jbrengineering.co.uk; s=protonmail; t=1662566612; x=1662825812;
        bh=mg0NLakcDSz4y9ygFZtcxm+uc74nt2rNCFdxlAemfbg=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=USKSMDLzbi0vDJw2ClAZcWvuRa8q2skvozT7uorOn5jq5yC6ZSgyWH0l2QSMFiJ22
         TvwyNLM7hZvtUukncmSyw/MZrYzs8ONOxq39T7skm7nZOZrTHNFkqPyw45zGpy8jw8
         p0zva41k0LejkL6wPr+QNyNB1wrk/YJRllmlzLXHvZSBhnc9DSuFFg8Sym1vpsvsYU
         I+bLgkyOhaczo3ZZSdJMrJ5zTN/U25s5cxvLgtz61SKdFQpXh1dANyYHK6kprpCbux
         aH4sI5kiBAzO1LmeQ5fdH1Asm7q3WBjNx90xzI9DiRYaOHaVuJkYYu4PjtvjZZiydS
         WJg88GlVZMOdw==
To:     Marc Kleine-Budde <mkl@pengutronix.de>
From:   john@jbrengineering.co.uk
Cc:     linux-can@vger.kernel.org,
        John Whittington <git@jbrengineering.co.uk>
Reply-To: john@jbrengineering.co.uk
Subject: Re: [PATCH v3 0/2] can: gs_usb: hardware timestamp support
Message-ID: <0Nvw-m4ZpxK2K87aKrgefC2nnb1wttIzaDSGpZMevO6Cb-iDzGDa07UmJ_SOON0mGZ00KITT3wCS_TuE-K0QacPZUBcFeKWydZXGRTobjuA=@jbrengineering.co.uk>
In-Reply-To: <20220907090446.r77d4bcfuqjsosii@pengutronix.de>
References: <20220827221548.3291393-1-mkl@pengutronix.de> <MyXI-Jx_HXvD27BZVEPozG9rRz0c-D4T73FwD7ilsKm9Keh1iUCYzO5mSisRm6LWa74OUxp22EJnguo3jE7VmjHZpXnZPYs7Y7hEU6p6LZM=@jbrengineering.co.uk> <20220905161309.ezcrba5x5vbrle47@pengutronix.de> <KLPjJ1XQVpVHMIl6lpZGPQNiHF1zmycOdfawTJ-t8fWSyg07npszgk0QUck3kbeJ6iRz_kgHDrLyuLng5dil3HnC93SQsGRv08nU-si_fqk=@jbrengineering.co.uk> <20220907090446.r77d4bcfuqjsosii@pengutronix.de>
Feedback-ID: 45109726:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wednesday, September 7th, 2022 at 11:04, Marc Kleine-Budde <mkl@pengutro=
nix.de> wrote:

> \o/ Have you found your issue?

Yes - a cyclical message period was outside of tolerance. First using hardw=
are timestamps was important to rule out any delay from host machine captur=
ing the messages and confirm the device was indeed deviating. Then once the=
 device was patched, confirming it was within spec required hardware timest=
amps too. I did find that host software timestamps would at times introduce=
 some delays not present on the bus (running in a VM with other tasks so un=
derstandable and they looked more like system delays than the periodic ones=
 created by un-patched device). The end result though was a fixed device an=
d happy outcome!

John.

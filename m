Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F185BF703
	for <lists+linux-can@lfdr.de>; Wed, 21 Sep 2022 09:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiIUHH6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Sep 2022 03:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiIUHHm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Sep 2022 03:07:42 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110BD81B25
        for <linux-can@vger.kernel.org>; Wed, 21 Sep 2022 00:07:33 -0700 (PDT)
Date:   Wed, 21 Sep 2022 07:07:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jbrengineering.co.uk; s=protonmail; t=1663744051; x=1664003251;
        bh=7Zbm01HzZpvFehVRE/ELfV/o0Ye1uCvlysiu5v3mb84=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=j5/IqTB/NYrXHPYW9qVYGxq51pIM7e1NwVyj5iydlfWUfBf2DV8fGg4RA4M5V/r8k
         DiqGIlpP7/r0v0ATzmp4A0xbO7um/oIA407wp6+rqBMIm9+uoksbNdo9tX32vcXgw6
         RwKnrbP7ysyVBddvvFSt2xJnqtpN+BidFNKPN9cZpZKxt/l4BHJBxka8J93Hlr4ycW
         xh74+IHygj1Q0MIi5g25HfA74b9Iw4dzDYaXFKIjP6gY+mYqZTALIvgfrbD4F7jKYj
         rgwSRsBRnijCe3YbF/iG/QTrUjNB2wHVKvYPFGfS7Fv7tCa1Lusecj2HNe+pKt9PiT
         7gBu7hSwXDJhQ==
To:     Marc Kleine-Budde <mkl@pengutronix.de>
From:   john@jbrengineering.co.uk
Cc:     linux-can@vger.kernel.org,
        John Whittington <git@jbrengineering.co.uk>
Subject: Re: (No Subject)
Message-ID: <wRg__4HuO0FuJrZu5M_JEbOd6MvCtxHq_aV86X_Bj-Dgb0YTRaoVO_sr6DpPcvwrhWtnNYwSCCWf0hJ8bCsFEYfon_iTkyctFDZOxOyO3x8=@jbrengineering.co.uk>
In-Reply-To: <20220920100416.959226-1-mkl@pengutronix.de>
References: <20220920100416.959226-1-mkl@pengutronix.de>
Feedback-ID: 45109726:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> while playing around with the hardware timestamping code, I found some
> issues, which are fixed in this series.
>=20
> John, can you test if timestamping still works on your hardware.

I've just tested the 3 patches and yes it still works. Thanks for picking u=
p on those.

I see a potential issue with 3/3: the timer not being stopped if the USB st=
art errors but I've replied in that thread.

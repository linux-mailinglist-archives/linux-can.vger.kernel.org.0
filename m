Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6585AFD36
	for <lists+linux-can@lfdr.de>; Wed,  7 Sep 2022 09:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiIGHNf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 7 Sep 2022 03:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiIGHNe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Sep 2022 03:13:34 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825C4A344D
        for <linux-can@vger.kernel.org>; Wed,  7 Sep 2022 00:13:20 -0700 (PDT)
Date:   Wed, 07 Sep 2022 07:13:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jbrengineering.co.uk; s=protonmail; t=1662534794; x=1662793994;
        bh=q7GGErztJWsY35Qib49IrktuTClZptNbqW+apzuM5vg=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=esKbZ1GJwSB6z7IukN5w3sdqhGZ0lXdv8NWSGGj/iPRTvU3SHZ9vH8ojIMUC5gNcW
         VE0SfqmadnI3SgMN9ReCprp2zWg6Y01WIA9vte4cZMVJvoBc5aTPsCW8puP+hkmWq8
         gFKWN4Gqx7VXKcPJYMWhm7wXTZYBYatCJvo+Jgyax0WYqA3hwXWupCOVf+touSEWSa
         Tmwrz7kJY8Xv+tXcNmQdH3WiQ2QV8dCJjMKQr1pnnB2B5jfuCKjqFS784yWWOuQZHB
         zSi8MjIaR7IZXPlNc8Gtfn6q0Z4NSB9od2LUHNraV+kw5wQC88z+XrqLwAaY60PhMy
         LneJFKVqA/ToA==
To:     Marc Kleine-Budde <mkl@pengutronix.de>
From:   john@jbrengineering.co.uk
Cc:     linux-can@vger.kernel.org,
        John Whittington <git@jbrengineering.co.uk>
Reply-To: john@jbrengineering.co.uk
Subject: Re: [PATCH v3 0/2] can: gs_usb: hardware timestamp support
Message-ID: <KLPjJ1XQVpVHMIl6lpZGPQNiHF1zmycOdfawTJ-t8fWSyg07npszgk0QUck3kbeJ6iRz_kgHDrLyuLng5dil3HnC93SQsGRv08nU-si_fqk=@jbrengineering.co.uk>
In-Reply-To: <20220905161309.ezcrba5x5vbrle47@pengutronix.de>
References: <20220827221548.3291393-1-mkl@pengutronix.de> <MyXI-Jx_HXvD27BZVEPozG9rRz0c-D4T73FwD7ilsKm9Keh1iUCYzO5mSisRm6LWa74OUxp22EJnguo3jE7VmjHZpXnZPYs7Y7hEU6p6LZM=@jbrengineering.co.uk> <20220905161309.ezcrba5x5vbrle47@pengutronix.de>
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

Yes, I have tested the v3 patch with candleLight_fw (c19f3a). `candump -H` =
works
as intended and I have actually used it in anger so to speak, debugging a t=
iming
tolerance issue with a CAN node.

I've also confirmed that `ethtool --show-time-stamping can0` returns the co=
rrect
timestamping info for both devices which do and don't include the
`GS_CAN_FEATURE_HW_TIMESTAMP` flag. Also that devices without that flag con=
tinue
to operate as before with the SocketCAN tools.

John.

------- Original Message -------
On Monday, September 5th, 2022 at 18:13, Marc Kleine-Budde <mkl@pengutronix=
.de> wrote:


>=20
>=20
> On 29.08.2022 13:25:00, john@jbrengineering.co.uk wrote:
>=20
> > Thanks for the support on this. I was following the threads but away
> > so unable to make changes. With the patch now squashed and your
> > updates, it looks like no further input is required from me on this.
>=20
>=20
> Can you test the v3 patch?
>=20
> Marc
>=20
> --
> Pengutronix e.K. | Marc Kleine-Budde |
> Embedded Linux | https://www.pengutronix.de |
> Vertretung West/Dortmund | Phone: +49-231-2826-924 |
> Amtsgericht Hildesheim, HRA 2686 | Fax: +49-5121-206917-5555 |

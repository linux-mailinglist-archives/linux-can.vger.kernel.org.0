Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D71759604
	for <lists+linux-can@lfdr.de>; Wed, 19 Jul 2023 14:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGSMzn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 19 Jul 2023 08:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjGSMzj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 19 Jul 2023 08:55:39 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9D51FCD
        for <linux-can@vger.kernel.org>; Wed, 19 Jul 2023 05:55:19 -0700 (PDT)
Date:   Wed, 19 Jul 2023 12:55:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jbrengineering.co.uk; s=protonmail3; t=1689771317; x=1690030517;
        bh=4JURnOmIbaUuOn25occoYAZ4bwYBkYcZbdrQoIBOnRg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=sDjUyVRde9/2s10wjUpbvmZXccuX9ao+0OOIDD3KHhodQcrVuZ0W8tBh3yYyrCsSi
         W+S/cpweu+gdn6UFdHPRrpYdGVnTGtCkmFJJKld7dpCfR9tAvyHhnyA0Ioufg04n2P
         i9QCl/4fJNuvrVRnefc2yMxvgIygT+11MaiXDn30LtvX7FE4g57QP/9ScjjZE3z0tg
         k3EcbtKOAHGBWZW6TpgNqJNwEjSHKIxD4dlcJbY9XJTMlr7B3FsiEtaPLnLdPqfqmP
         Yr6l8fjRjYqSUiePaWJC6UMv3vZiGBRs/tbYdabuPy+/h+ILHZoSAkaSrTbiBoAaoS
         jzRJF8CsiDtNw==
To:     Marc Kleine-Budde <mkl@pengutronix.de>
From:   john@jbrengineering.co.uk
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de,
        John Whittington <git@jbrengineering.co.uk>,
        stable@vger.kernel.org
Subject: Re: [PATCH 0/2] can: gs_usb: fix time stamp counter initialization
Message-ID: <C3H7gx4Krj3hjq14-A92mCFngjXEie679zE1xQvTosJTiMAbVmr9Z6_cLvWKfPjLOjOOKgOAWFBuMCp5J2HxRMCWZal7RAWwsEecEpnvkSI=@jbrengineering.co.uk>
In-Reply-To: <20230716-gs_usb-fix-time-stamp-counter-v1-0-9017cefcd9d5@pengutronix.de>
References: <20230716-gs_usb-fix-time-stamp-counter-v1-0-9017cefcd9d5@pengutronix.de>
Feedback-ID: 45109726:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

Thanks for this. I've had a look and tested it (candleLight_fw v2.0, `candu=
mp can0 -H`, unload) and all seems good.

John.

------- Original Message -------
On Sunday, July 16th, 2023 at 21:33, Marc Kleine-Budde <mkl@pengutronix.de>=
 wrote:


>=20
>=20
> During testing I noticed a crash if unloading/loading the gs_usb
> driver during high CAN bus load.
>=20
> The current version of the candlelight firmware doesn't flush the
> queues of the received CAN frames during the reset command. This leads
> to a crash if hardware timestamps are enabled, it a URB from the
> device is received before the cycle counter/time counter
> infrastructure has been setup.
>=20
> First clean up then error handling in gs_can_open().
>=20
> Then, fix the problem by converting the cycle counter/time counter
> infrastructure from a per-channel to per-device and set it up before
> submitting RX-URBs to the USB stack.
>=20
> Signed-off-by: Marc Kleine-Budde mkl@pengutronix.de
>=20
> ---
> Marc Kleine-Budde (2):
> can: gs_usb: gs_can_open(): improve error handling
> can: gs_usb: fix time stamp counter initialization
>=20
> drivers/net/can/usb/gs_usb.c | 130 ++++++++++++++++++++++++--------------=
-----
> 1 file changed, 74 insertions(+), 56 deletions(-)
> ---
> base-commit: 0dd1805fe498e0cf64f68e451a8baff7e64494ec
> change-id: 20230712-gs_usb-fix-time-stamp-counter-4bd302c808af
>=20
> Best regards,
> --
> Marc Kleine-Budde mkl@pengutronix.de
>=20
> 

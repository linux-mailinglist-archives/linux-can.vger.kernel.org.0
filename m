Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A20A5BF711
	for <lists+linux-can@lfdr.de>; Wed, 21 Sep 2022 09:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiIUHIM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Sep 2022 03:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiIUHH5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Sep 2022 03:07:57 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395BE82771
        for <linux-can@vger.kernel.org>; Wed, 21 Sep 2022 00:07:56 -0700 (PDT)
Date:   Wed, 21 Sep 2022 07:07:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jbrengineering.co.uk; s=protonmail; t=1663744074; x=1664003274;
        bh=jBjE3tHEvKHcsS/6olQjLjMt0FgIll7fz0+yY3G2baM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=XbbrwFlX1j7uDEC85FS8hDPPV3OhKjb2tJcUfs8bNsHJqqSDraohfhQqxGxIQSCfu
         OR87cXzGl48sr56nxZFvI/9pz3b8416tTYMchW4wXIBz8FsMW05gRtQMtIJXZvxnND
         2CFDMOkQe/yc+B2mItTIMj8WEdGFPe6nzQSGmzClh0eSVVqOT9rq4QSoOj/C9XXa1/
         txlB7qMYxoxnjfrdviSGRFkHnFHr2sna0PhYlniQQGKXLj5Xhj5OfkOdwOkQh/uL4K
         cX7pCZEx8MotDisw1YguG01DTszXmLxektO284lXSUR0p7PcWdG6YRsEjyhQW4a7XB
         g8oPVx/nw9CFg==
To:     Marc Kleine-Budde <mkl@pengutronix.de>
From:   john@jbrengineering.co.uk
Cc:     linux-can@vger.kernel.org,
        John Whittington <git@jbrengineering.co.uk>
Subject: Re: [PATCH 3/3] can: gs_usb: gs_can_open(): initialize time counter before starting device
Message-ID: <WruyTFnj_BnMkA_prvKr9MgOHemFhgSpOaxf1OSJDWJQuGqc1-h6qSOctxPTwOqkzRudA-JKYxpLy_FfCR0vVaQepGCE5AC5VhcDKBzXJ0w=@jbrengineering.co.uk>
In-Reply-To: <20220920100416.959226-4-mkl@pengutronix.de>
References: <20220920100416.959226-1-mkl@pengutronix.de> <20220920100416.959226-4-mkl@pengutronix.de>
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

> On busy networks the CAN controller might receive CAN frames directly
> after starting it but before the timecounter is setup. This will lead
> to NULL pointer deref while converting the converting the CAN frame's
> timestamp with the timecounter.
>=20
> Close the race window by setting up the timecounter before starting
> the CAN controller.

My logic of starting the timer after the USB request to start was due to th=
e function returning before if the USB start request returns an error. With=
 this change, the timer will be started and poll the USB timestamp request =
even if the device is not started - I tested and confirmed this is the case=
.

I agree with the issue this patch solves and flaw previously but believe it=
 requires a check of the GS_CAN_FEATURE_HW_TIMESTAMP and gs_usb_timestamp_s=
top(dev) in the rc < 0 check.

if (rc < 0) {
  netdev_err(netdev, "Couldn't start device (err=3D%d)\n", rc);
  kfree(dm);
  /* stop polling timestamp */
  if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
    gs_usb_timestamp_stop(dev);
  return rc;
}

John. 

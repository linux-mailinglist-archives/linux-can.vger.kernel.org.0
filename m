Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA894B577D
	for <lists+linux-can@lfdr.de>; Mon, 14 Feb 2022 17:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345748AbiBNQzO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Feb 2022 11:55:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352879AbiBNQzN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Feb 2022 11:55:13 -0500
X-Greylist: delayed 530 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 08:55:04 PST
Received: from outbound.soverin.net (outbound.soverin.net [116.202.126.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B0865157
        for <linux-can@vger.kernel.org>; Mon, 14 Feb 2022 08:55:04 -0800 (PST)
Received: from smtp.freedom.nl (unknown [10.10.3.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by outbound.soverin.net (Postfix) with ESMTPS id 4FF3C2A0
        for <linux-can@vger.kernel.org>; Mon, 14 Feb 2022 16:46:13 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [116.202.65.211]) by soverin.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=zevv.nl; s=soverin;
        t=1644857172; bh=n/4PTC13fKZPdmM1dUHDYkZE2STevtm2yCPJkok2tAI=;
        h=From:To:Subject:Date:From;
        b=oUZHF+dEqAg61wUi9prnIFJ+oMWwLp6o+Ufbve3gNmiZOr3jIrBdwzZ9PPHcgRxmo
         GyxO/F4usXiWPJcJDif1jfV4yLTAtHhl32llReO8hS3I1gnUrHlBdqmZjoVNOb/8mE
         YdvONHIrL84MNCSkC11/VT5w9IrP9/Zm+xH+6717xeb7Ll4KOd2BAPDOspv5LAKf1N
         ICeoYufooplUkF1olPIjbMrNTS1xak9xkCtEY2aa7I7aFqybHm8dgucBYM2RzHcJzt
         +Kqno3z60sJx3W6hJdh/T05cD/qetjhm6ZTg2gFNwzsRpTt63KfKomPvXmBmVh86PX
         hZ2kFxa754gRg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From:   Ico Glass <can@zevv.nl>
To:     linux-can@vger.kernel.org
Subject: lack of bus-off recovery in slcan driver
Date:   Mon, 14 Feb 2022 17:46:11 +0100
Message-ID: <164485717170.1363325.15056183544396793343@mdoos>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

One of our customers uses the lawicel CANUSB can interface with the
slcan driver, and we have noticed that in some tests where we introduce
electrical errors to the bus the driver becomes unresponse, being no longer
able to either send or receive any CAN frames. Reattaching the interface
seems to mitigate the error.

The suspicion is that the interface drops into bus-off mode; the serial
protocol documentation of the CAN interface talks about an 'F' command
for querying status bits, but it seems that the slcan driver does not
implement this and has no knowledge of the interface is in a defunct
state.

`ip restart` or `ip restart-ms` both seem to be not implemented for this
driver unfortunately:

   RTNETLINK answers: Operation not supported

Is there a clean programmatic method for detecting and recovering from
error states using the slcan driver? Is this CANUSB interface a good
choice to use in production, or should we consider it "hobby quality"
only?

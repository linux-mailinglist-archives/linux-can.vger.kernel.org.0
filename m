Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E904BFD6E
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 16:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiBVPtF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 10:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiBVPtE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 10:49:04 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A7F33A29
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 07:48:39 -0800 (PST)
Received: from photo-meter.com ([62.157.68.154]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MfHMj-1ntyTX28y3-00grtV; Tue, 22 Feb 2022 16:48:36 +0100
Received: from [192.168.100.109] (MICHA.fritz.box [192.168.100.109])
        by photo-meter.com (Postfix) with ESMTP id E2D343B08B7;
        Tue, 22 Feb 2022 16:46:29 +0100 (CET)
Message-ID: <00d47d39-7f93-6151-5e1a-572e75768eec@photo-meter.com>
Date:   Tue, 22 Feb 2022 16:48:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Reply-To: anochin@photo-meter.com
Subject: Re: can: m_can: tcan4x5x m_can_isr do not handle tx if rx fails
Content-Language: de-DE
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <93aa0ce4-8df2-bcad-237b-c6ce1bdcff0e@photo-meter.com>
 <20220222132000.xiopvrtu5fmuanbz@pengutronix.de>
 <c2651e9c-d3e7-815a-6e18-8ddffc04d3d7@photo-meter.com>
 <20220222134419.zmycnlmhrrrewggf@pengutronix.de>
 <e3504807-06fc-b6d9-3fb1-bf8d94e2b444@photo-meter.com>
 <20220222144518.j4swrtcv4rsyagem@pengutronix.de>
 <cde7fa96-adc6-d9ca-72a3-056569623936@photo-meter.com>
 <20220222150619.sqyagvuspbipywxl@pengutronix.de>
 <1c9764e5-dd8b-853a-08e2-547acf7e9e76@photo-meter.com>
 <20220222154314.y4scgsssl4mx5z2n@pengutronix.de>
From:   Michael Anochin <anochin@photo-meter.com>
Organization: Czibula und Grundmann GmbH
In-Reply-To: <20220222154314.y4scgsssl4mx5z2n@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:fipXGqmDRvrVZFNh/nNSjgs+5sZXn+yFWS1WiF8o3zaczyp0N9q
 r7Wiy8QtsX8THTfKPlWMURdqqOQpIqrCoYeAS32RRaHUvqsolUPdNIV8X5mDsjT/O17KzKG
 2aNzk7lCTtJi6S2X9UVbKPVWQ1OJEpLGPR4AW1BEOmUYu+KOa1xGJyav7JNK3csXDiWQTk6
 FDppam42pHnCCRd5BLtqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:byWNj4r987M=:F5Lo9zysbA/j+lsEpjtfZ/
 lmWoD7D1PUR63wIt2mp+JDnv98MYJMRmnlZypg0+TSCLucBjtbVdkX6y9wyP8dK+vjFyDSf1m
 40jEmJt55In5WS6HMPog3cGadafTYxVzvtYhBPG6z6IMovp7QLGuVuqXhGE1sbuNI+7jsW5+z
 iXcQv5JettJ2Mm8YKZ0ziOooWaIbG/a4UyNHs9yCuJGAyPnPkxd/fg6VQtqznbKgcssjQgzzg
 qqv2hDFsDj1AHV8Md0ec2IokpxmOAdw0mV/M6b69wzpKpMxIC1d9Ta6terPJtWhynz9U3N/4A
 qNJ1seIcf8VRDhrp5V/FrZnYWFvkOacPbiWMxb4oF18fNDfqLBlEBS6HtehvEjC2cgE6QHjOe
 MIMqAGhTXEzIU0h6mu7nNaHOw6o8uHAsy7ZMbA+Q7kHCgFKs228dwWQnvED/7ipbCB9INlElJ
 56dUABzFJTUxKOxYNPvjDBLSvLiek7LewES/53FNvpFfq/32qLOP1WJ5rM9HR060BuCg5E1bk
 eaYJJB5YoRyANt6QX6vdHWjrZpV+Cd8O7pXsFGrkgR3/2GHSQJhiEkp0rtoEwc3CouQkJ8XTw
 IVF1y2mzLvsrDNFIRRHLRcu4FA2mkG3dzFwoJz+osz2QfYgNYHQmpNmwvsAR77KF6IX8Z7pmM
 VNFK6fCSLzSMIu2b6Q/Oa8F5a0UV/Hiwejw3CfgCIvNSATN3i5V4TRYu4yjdx5PloYdeTus8t
 DbWQ7zXhfPzwhgDa
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> Keep us informed if that helps.
No, this does not help. It was my start-point with <0x0 0 0 16 0 0 1 1>
I continue to dive in with debug-printing.

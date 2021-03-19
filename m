Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEA33416DD
	for <lists+linux-can@lfdr.de>; Fri, 19 Mar 2021 08:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbhCSHtr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Fri, 19 Mar 2021 03:49:47 -0400
Received: from relay.stp.tds-sharedservices.de ([185.55.232.170]:59827 "EHLO
        relay.stp.tds-sharedservices.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234084AbhCSHtg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Mar 2021 03:49:36 -0400
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Mar 2021 03:49:36 EDT
Received: from relay.stp.tds-sharedservices.de (localhost [127.0.0.1])
        by relay.stp.tds-sharedservices.de (Postfix) with SMTP id 35FBCC0481
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 08:44:24 +0100 (CET)
Received: from stpinfexc1vp.corporate.storopack.net (stpinfexc1vp.nat.tds.rz [10.252.18.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay.stp.tds-sharedservices.de (Postfix) with ESMTPS id 1D34EC0465
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 08:44:24 +0100 (CET)
Received: from stpinfexc1vp.corporate.storopack.net (10.252.18.138) by
 stpinfexc1vp.corporate.storopack.net (10.252.18.138) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 19 Mar 2021 08:44:23 +0100
Received: from stpinfexc1vp.corporate.storopack.net ([10.252.18.138]) by
 stpinfexc1vp.corporate.storopack.net ([10.252.18.138]) with mapi id
 15.00.1497.012; Fri, 19 Mar 2021 08:44:23 +0100
From:   "Wadepohl, Wolfram" <wolfram.wadepohl@storopack.com>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: newbie question to atu baudrate detection
Thread-Topic: newbie question to atu baudrate detection
Thread-Index: Adcck1/8RAMO7ayjTNONzP4Q4WYCaw==
Date:   Fri, 19 Mar 2021 07:44:23 +0000
Message-ID: <34a81be300da495db62c369863ae9873@stpinfexc1vp.corporate.storopack.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.13.24.12]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Is it possible to automatically detect baudrate via socketCAN? How can I set the CAN controller to "silent mode" not generating any ACK or error frames?
help would be appreciated. thanks.

--
Wolfram Wadepohl
Plattformtechnologien & Datenmanagement
Storopack
Deutschland GmbH & Co. KG

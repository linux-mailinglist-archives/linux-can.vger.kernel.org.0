Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96DE45E38D
	for <lists+linux-can@lfdr.de>; Fri, 26 Nov 2021 00:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbhKYX6B (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Nov 2021 18:58:01 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:39121
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S232344AbhKYX4B (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Nov 2021 18:56:01 -0500
Received: by ajax-webmail-mail-app2 (Coremail) ; Fri, 26 Nov 2021 07:43:53
 +0800 (GMT+08:00)
X-Originating-IP: [115.204.154.165]
Date:   Fri, 26 Nov 2021 07:43:53 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, mkl@pengutronix.de, davem@davemloft.net,
        kuba@kernel.org
Subject: Re: Re: [PATCH v0] can: raw: supplement the check to prevent the
 NPD
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2021 www.mailtech.cn zju.edu.cn
In-Reply-To: <0801ace2-5885-d579-aa8f-177c0cc5c2da@hartkopp.net>
References: <20211125084655.16974-1-linma@zju.edu.cn>
 <0801ace2-5885-d579-aa8f-177c0cc5c2da@hartkopp.net>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7de16f2f.7a0d4.17d597bebe2.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: by_KCgAnCvW5H6BhmT8TAQ--.18323W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwUTElNG3EwKKwAHsk
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgT2xpdmVyLAoKT29wcywgeWVhaCBpdCBzZWVtcyB0byBiZSBhIGZhbHNlIGFsYXJtLCBzb3Jy
eSBmb3IgdGhhdC4gWEQKCk1vcmVvdmVyLCB0aGFua3MgZm9yIHlvdXIgd2FybSByZXBseS4gVGhh
bmtzIQoKQmVzdCByZWdhcmRzCkxpbg==

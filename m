Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6F5D42FE
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2019 16:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfJKOhD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 11 Oct 2019 10:37:03 -0400
Received: from mx.krause.de ([88.79.216.98]:45403 "EHLO mx.krause.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfJKOhC (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 11 Oct 2019 10:37:02 -0400
Received: from [172.20.10.125] (port=52458 helo=mail.horstmanngroup.de)
        by mx.krause.de with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <t.schluessler@krause.de>)
        id 1iIw06-0005FT-1q; Fri, 11 Oct 2019 16:34:38 +0200
Received: from HG-SRV-053.HG.local (172.20.10.125) by HG-SRV-053.HG.local
 (172.20.10.125) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 11 Oct
 2019 16:34:38 +0200
Received: from HG-SRV-053.HG.local ([::1]) by HG-SRV-053.HG.local ([::1]) with
 mapi id 15.00.1367.000; Fri, 11 Oct 2019 16:34:38 +0200
X-CTCH-RefID: str=0001.0A0C020C.5DA092FE.0089,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   =?utf-8?B?U2NobMO8w59sZXIsIFRpbW8=?= <t.schluessler@krause.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] can: mcp251x: Add GPIO support
Thread-Topic: [PATCH v3 3/3] can: mcp251x: Add GPIO support
Thread-Index: AQHVgDkz1ZvvhErBD0CxKEcJ7UQz66dVVyCAgAAoX3A=
Date:   Fri, 11 Oct 2019 14:34:38 +0000
Message-ID: <ce2e1ba6e3654a8fac3c35f301ef7802@HG-SRV-053.HG.local>
References: <1570801101-27864-1-git-send-email-schluessler@krause.de>
 <1570801101-27864-3-git-send-email-schluessler@krause.de>
 <c00ad0e9-08ae-ddbe-a0ad-6ab5ee5bff41@pengutronix.de>
In-Reply-To: <c00ad0e9-08ae-ddbe-a0ad-6ab5ee5bff41@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.35.50]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

T24gMTAvMTEvMTkgNDowMyBQTSwgTWFyYyBLbGVpbmUtQnVkZGUgd3JvdGU6DQoNCj4gSGF2ZSB5
b3UgcmVhZCBteSBlbnRpcmUgcmV2aWV3IG9mIHRoZSB2MiBQYXRjaD8NCg0KTm8sIHVuZm9ydHVu
YXRlbHkgSSBkaWRuJ3Qgc2VlIHRoZSBjb21tZW50cyBmdXJ0aGVyIGRvd24gdGhlIHBhdGNoLiBJ
cyBpdCBvayB0byByZXNlbmQgb25seSB0aGlzIHBhdGNoIG9yIHNoYWxsIEkgcmVzZW5kIGFsbCB0
aHJlZSB3aXRoIHZlcnNpb24gND8NCg0KVGhhbmtzDQpUaW1vDQoNCg==

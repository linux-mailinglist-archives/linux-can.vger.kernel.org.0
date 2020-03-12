Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 637AD1837E6
	for <lists+linux-can@lfdr.de>; Thu, 12 Mar 2020 18:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgCLRnm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 12 Mar 2020 13:43:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:59599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLRnm (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 12 Mar 2020 13:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584035020;
        bh=06+LFNbdYLtElPmSnUkOI3cN7U8bT0hwQBSWBEY8ixw=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=EukDSccoFWNV+q550P7uAmHoCE3fII8aUYO5Uyz4ZEYJzHLmhSEnWdf4kGvqtZR5F
         0+UCT3J1BVk98kTwYyeW4/ioXkUUJAaUTomabrqpZVfkEA6dEOeJoOytfZXphbg70m
         HgWV0xBrmSDPzsnESPgAaY2ooVAjgsuwQb/k7zWg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.102] ([84.176.144.33]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MN5if-1iw9VO3rpl-00J0GY for
 <linux-can@vger.kernel.org>; Thu, 12 Mar 2020 18:43:40 +0100
Subject: Re: Need help in interpreting ip status output
From:   =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <a6c8ef8c-5c72-7a2b-98df-0a30057c5fdc@gmx.de>
Message-ID: <f029f731-25bc-a3f0-c5a9-380012a16839@gmx.de>
Date:   Thu, 12 Mar 2020 18:43:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a6c8ef8c-5c72-7a2b-98df-0a30057c5fdc@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:qIapIrnpPhi3YGixvWcKVcTRD5aUXGLhR1Qllq5JNLgp0Wbcd1k
 kDOqhA2wv2o9g/vPWaJLpadLIdclAPRhRet5vJh/rCfT6WOBLOOopnr2OGYitFWi86kUXDt
 ij3mY6VJWmK9MWJ5XSn1gXYFx8A3mDh5lJnPqoQ4T1Xdp9Ru4PGz83x2G2BxCoLW3luc24w
 G1xq7Db6LHPNnEGuAV9tw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WZvD3YFvHh4=:fg88Y8mSDdbbg2dhpAJ5wB
 YGI7a4RFOfsJplqJTYlla/BoYFKwhWrYO3/oCMk0PM26MnvCkYOiTopeODnVHQQb/7UPRX412
 E7Esrp0/RHpiH6KrfR4huwwVP2xpIXmo5XnE7HnZ7ktwyT1BxVGRX4FmujUU5JK0DVtYMnsJJ
 LdUBVYC1OUM2ZaiD8YKVffN6e4g+esO3CQfan7TA3Jp5S/dn6HHxwpWu0IBCvo8WQNbRgT4YK
 jt6IzEgqycY9sj7XqR8hAmPfcFYOpqtzgBQcTYdXgc64QfgqGyxVg81M0qmOyYhiyVHWPYKcX
 G48J0hq01SYXftXyEWfg65LhozMXrUNCnHZSvJWnhnSoKFZVXI3/Rif1cj9PjLbT7lZACryVm
 KgIpd0DkN1uuoPtBmwM2ItPoFrE+WERIcXPeVh5TYdbtTicyDcF5rAMK1Qo8Zu7wTJ8cEfyb5
 /3ZyppFcj3Yuu16gbrLqdUvxuxyPlKC8Wdq7QougTREWt8wANse2cB9+/goYk7llxW1uOt2a7
 xcRuWk4L5uUaYzBZrxznBPrgjwfUtEB5NSNN8S75nbKpgGx1wiXzZBktHV9+RU/+Ddipqq447
 U+VqF/ihpUK2LAIS+hGUhQyi2GjkSbl1dp4XGCNSY8K9HV3+phT7X+y6s2hfNZiQP/JMnTtMy
 ZugRPMnaFc2+RixbVcYSWPDnPK83XSg2MDxZam3EFlUZU9qOCzbcs/t4wD6M72LdIayfoTAI5
 EZTA070vfpIk6jfMqC0LGFldMk1wryUtJZHWhXQgd4vuzoJDB9SEH1hHVIQNIY3hrqtIR7bd8
 KqfOqkqTpnsnO7aOa5MFZQsWVET0MM7f9H6WE53gOd5oF+KuXJvIDzinNhVUhvRK4SQRr5iCi
 xRajtK2fdrruB7D6ImmSjNqKw5KDVlMbRez4LW8ohVxnwanAH1upoG9iv0qWDzuEMd52R3Vu4
 H22jDQ3T/GwAnJgNAMp6Z/EqyWEzmfLRQYbFMmmCDz8Vrj2sqJZIG9EyMgump4/SJJNWDHvRu
 O9VMHkKfgRkRcfGrzKw2YBAAhqBWxu/NRaUzdQ6iEO1t3HKfRBsdJ9iBudoySZ/nQGc0+a+bQ
 BM7LT7CFclBxyqlY38YvvHouzFCZmjDCVcur38euCgubTa2c4InpIEs0qI2x915STlZ4IDcQh
 KfavHwWugWsdTmqpf2fwir6nBTJuWgmMzaYihat1lNIwJ7m06iMwGFBgORds15mVRhmB0bRF+
 DzskyscN9thLx+wcw
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGFzIG5vIG9uZSBhbiBpZGVhPw0KDQpSZWdhcmRzLCBBbmRyw6kNCg0KT24gMDYuMDMuMjAgMjE6
MTMsIEFuZHLDqSBIYXJ0bWFubiB3cm90ZToNCj4gSGkgYWxsLA0KPiANCj4gY2FuIHNvbWVvbmUg
aGVscCBtZSBpbnRlcnByZXRpbmcgdGhlIGZvbGxvd2luZyBpcCBvdXRwdXQ6DQo+IA0KPiBpcCAt
cyBsaW5rIHNob3cgY2FuMQ0KPiAgwqDCoMKgwqAgMzogY2FuMTogPE5PQVJQLFVQLExPV0VSX1VQ
LEVDSE8+IG10dSAxNiBxZGlzYyBwZmlmb19mYXN0IHN0YXRlIA0KPiBVTktOT1dOIG1vZGUgREVG
QVVMVCBncm91cCBkZWZhdWx0IHFsZW4gMTAwDQo+ICDCoMKgwqDCoMKgwqDCoMKgIGxpbmsvY2Fu
DQo+ICDCoMKgwqDCoMKgwqDCoMKgIFJYOiBieXRlc8KgIHBhY2tldHPCoCBlcnJvcnPCoCBkcm9w
cGVkIG92ZXJydW4gbWNhc3QNCj4gIMKgwqDCoMKgwqDCoMKgwqAgMMKgwqDCoMKgwqDCoMKgwqDC
oCA5OTg3NDEzwqAgMcKgwqDCoMKgwqDCoCA3NMKgwqDCoMKgwqAgMcKgwqDCoMKgwqDCoCAwDQo+
ICDCoMKgwqDCoMKgwqDCoMKgIFRYOiBieXRlc8KgIHBhY2tldHPCoCBlcnJvcnPCoCBkcm9wcGVk
IGNhcnJpZXIgY29sbHNucw0KPiAgwqDCoMKgwqDCoMKgwqDCoCAwwqDCoMKgwqDCoMKgwqDCoMKg
IDDCoMKgwqDCoMKgwqDCoCAwwqDCoMKgwqDCoMKgIDDCoMKgwqDCoMKgwqAgMMKgwqDCoMKgwqDC
oCAwDQo+IA0KPiBJJ20gZXNwZWNpYWxseSBpbnRlcmVzdGVkIGluIHRoZSBtZWFuaW5nIG9mIHRo
ZQ0KPiANCj4gKiAxIGVycm9ycw0KPiAqIDc0IGRyb3BwZWQNCj4gKiAxIG92ZXJydW4NCj4gDQo+
IGZpZWxkcy4NCj4gDQo+IFRoYW5rcyBhbmQgYmVzdCByZWdhcmRzLA0KPiBBbmRyw6kNCg0K

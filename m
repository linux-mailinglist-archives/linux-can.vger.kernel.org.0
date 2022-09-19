Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDB05BD36C
	for <lists+linux-can@lfdr.de>; Mon, 19 Sep 2022 19:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiISROs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Sep 2022 13:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiISROq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Sep 2022 13:14:46 -0400
Received: from mail1-emea.wika.com (mail1-emea.wika.com [195.145.204.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34707261B
        for <linux-can@vger.kernel.org>; Mon, 19 Sep 2022 10:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=wika.com; i=@wika.com; q=dns/txt; s=wika1;
  t=1663607685;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b3HJzwk4SPMHp/ulnMnz4i67KEx6F7tXl8ly9yv0QKY=;
  b=hf+bKAMBt4nY2R7YVxdAu1uKkk1mM1ptmI6n1x2Wa9Y+S1yRnOLI0xuA
   ztMwjBhmYCxS3BtDlNpUcHxYEbAKsJbfmUxMHmarEijCZYP1xsi6GHp0v
   gVZKHldnwEl1xAfOO+ooCLjIxL3m+WE27UFhP87fpoVlGIN65SnOXF4wp
   75HlKSSGIxmJ5n9QbcxEpOq1dujjz9pj4KBQOTKp5NpmdO0kPwqjr1j0c
   M2uHGNlJ4bXzc4SKAgZfPu5eYroyJuYSOlhwiaHopVRVoX8N2jpPEwB+B
   0CGbu8xwdaEzxMlmnjpoI4dMPXk40JZARm095kWNVSzZrrPliLGLkLJ1N
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,328,1654552800"; 
   d="scan'208";a="24791450"
Received: from unknown (HELO USATL1S6501.corp.root.int) ([172.17.4.221])
  by mail1-emea.wika.com with ESMTP/TLS/ECDHE-RSA-AES128-SHA; 19 Sep 2022 19:14:40 +0200
Received: from USATL1S6502.corp.root.int (172.17.4.222) by
 USATL1S6501.corp.root.int (172.17.4.221) with Microsoft SMTP Server
 (version=TLS1_1, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA_P256) id
 15.1.2507.9; Mon, 19 Sep 2022 13:14:39 -0400
Received: from USATL1S6502.corp.root.int ([fe80::25de:b226:769c:6e35]) by
 USATL1S6502.corp.root.int ([fe80::25de:b226:769c:6e35%12]) with mapi id
 15.01.2507.009; Mon, 19 Sep 2022 13:14:39 -0400
From:   "Trevitz, Daniel" <Daniel.Trevitz@wika.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     Ryan Edwards <ryan.edwards@gmail.com>
Subject: RE: [PATCH v2 3/3] can: gs_usb: add switchable termination support
Thread-Topic: [PATCH v2 3/3] can: gs_usb: add switchable termination support
Thread-Index: AQHYy6Qn3CN19ElUP0SIyc5f1WgmVa3m/LTg
Date:   Mon, 19 Sep 2022 17:14:39 +0000
Message-ID: <46b828feda4c4ef3bf978dd186b094af@wika.com>
References: <20220918211802.692405-1-mkl@pengutronix.de>
 <20220918211802.692405-4-mkl@pengutronix.de>
In-Reply-To: <20220918211802.692405-4-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.6.20]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-GBS-PROC: nzy5iiIda39ucI2qNLF3y8PI1EhhrkxBKnWcec5sPEis+4FlaVMGWCjPTtWeJN4I
X-GBS-PROCJOB: 2f1wiqyU7B/2CK5oISlAjwWESGkZN0pTt1ZFu+UuCLR4RGd47SLzoagCXaFGEd0/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

TWFyYywNCg0KKyAgICAgICBpZiAoZmVhdHVyZSAmIEdTX0NBTl9GRUFUVVJFX1RFUk1JTkFU
SU9OKSB7DQorICAgICAgICAgICAgICAgZGV2LT5jYW4udGVybWluYXRpb25fY29uc3QgPSBn
c191c2JfdGVybWluYXRpb25fY29uc3Q7DQorICAgICAgICAgICAgICAgZGV2LT5jYW4udGVy
bWluYXRpb25fY29uc3RfY250ID0gQVJSQVlfU0laRShnc191c2JfdGVybWluYXRpb25fY29u
c3QpOw0KKyAgICAgICAgICAgICAgIGRldi0+Y2FuLmRvX3NldF90ZXJtaW5hdGlvbiA9IGdz
X3VzYl9zZXRfdGVybWluYXRpb247DQorDQorICAgICAgICAgICAgICAgcmMgPSBnc191c2Jf
Z2V0X3Rlcm1pbmF0aW9uKG5ldGRldiwgJmRldi0+Y2FuLnRlcm1pbmF0aW9uKTsNCisgICAg
ICAgICAgICAgICBpZiAocmMpIHsNCisgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIo
JmludGYtPmRldiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkNvdWxkbid0
IGdldCBjdXJyZW50IHRlcm1pbmF0aW9uIHN0YXRlIGZvciBjaGFubmVsICVkICglcGUpXG4i
LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjaGFubmVsLCBFUlJfUFRSKHJj
KSk7DQorICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dF9mcmVlX2NhbmRldjsNCisg
ICAgICAgICAgICAgICB9DQorICAgICAgIH0NCg0KRG9lcyBpdCBtYWtlIHNlbnNlIHRvIGNo
ZWNrIGlmIHdlIGhhdmUgdGhlIHRlcm1pbmF0aW9uIHN1cHBvcnQsIHRoZW4gc2V0IHRoZSB2
YWx1ZXM/DQpNeSBsb2dpYyBpcyB0aGF0IGp1c3QgYmVjYXVzZSB0aGUgdGVybWluYXRpb24g
aXMgbm90IHdvcmtpbmcgY29ycmVjdGx5LCBpdCBkb2VzIG5vdCBtZWFuIGV2ZXJ5dGhpbmcg
aXMgYnJva2VuLg0KVGhpcyB3YXkgeW91IGNvdWxkIGhhdmUgYSBtdWx0aS1jYW4tY2hhbm5l
bCBVU0IgZGV2aWNlIGJ1dCB3aXRoIG9ubHkgc3BlY2lmaWMgY2hhbm5lbHMgc3VwcG9ydGlu
ZyBjb25maWd1cmFibGUgdGVybWluYXRpb24gcmVzaXN0b3JzLg0KDQpTb21ldGhpbmcgbGlr
ZToNCg0KcmMgPSBnc191c2JfZ2V0X3Rlcm1pbmF0aW9uKG5ldGRldiwgJmRldi0+Y2FuLnRl
cm1pbmF0aW9uKTsNCiBpZiAocmMpIHsNCglkZXZfZXJyKCZpbnRmLT5kZXYsDQoJCSJDb3Vs
ZG4ndCBnZXQgY3VycmVudCB0ZXJtaW5hdGlvbiBzdGF0ZSBmb3IgY2hhbm5lbCAlZCAoJXBl
KS4gTm90IGVuYWJsaW5nIHRlcm1pbmF0aW9uIHN1cHBvcnQgZm9yIHRoaXMgY2hhbm5lbFxu
IiwNCgkJY2hhbm5lbCwgRVJSX1BUUihyYykpOw0KIH0gZWxzZSB7DQoJZGV2LT5jYW4udGVy
bWluYXRpb25fY29uc3QgPSBnc191c2JfdGVybWluYXRpb25fY29uc3Q7DQoJZGV2LT5jYW4u
dGVybWluYXRpb25fY29uc3RfY250ID0gQVJSQVlfU0laRShnc191c2JfdGVybWluYXRpb25f
Y29uc3QpOw0KCWRldi0+Y2FuLmRvX3NldF90ZXJtaW5hdGlvbiA9IGdzX3VzYl9zZXRfdGVy
bWluYXRpb247DQp9DQoNCkJSLA0KICBEYW5pZWwNCg0KDQoNCg0KKipDT05GSURFTlRJQUxJ
VFkgTk9USUNFKioNCg0KDQpUaGlzIGNvbW11bmljYXRpb24sIGluY2x1ZGluZyBhbnkgYXR0
YWNobWVudHMsIGlzIGZyb20gV0lLQSBNb2JpbGUgQ29udHJvbCwgTFAgYW5kIGNvbnRhaW5z
IGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBpbnRlbmRlZCBvbmx5IGZvciB0aGUgYWRkcmVz
c2VlKHMpLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBhbnkgdXNl
LCBkaXNzZW1pbmF0aW9uLCBkaXN0cmlidXRpb24gb3IgY29weWluZyBvZiB0aGlzIGRvY3Vt
ZW50IG9yIGl0cyBjb250ZW50cyBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLiBJZiB5b3UgaGF2
ZSByZWNlaXZlZCB0aGlzIGNvbW11bmljYXRpb24gaW4gZXJyb3IsIHBsZWFzZSBjb250YWN0
IHRoZSBzZW5kZXIgYnkgcmVwbHkgZS1tYWlsIGltbWVkaWF0ZWx5IGFuZCBkZXN0cm95IGFs
bCBjb3BpZXMgb2YgdGhlIG9yaWdpbmFsIG1lc3NhZ2UuIA0K

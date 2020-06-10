Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207761F4FEF
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2020 10:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgFJIId (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 10 Jun 2020 04:08:33 -0400
Received: from mail-eopbgr80111.outbound.protection.outlook.com ([40.107.8.111]:36933
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726207AbgFJIIc (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 10 Jun 2020 04:08:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3ZvdfqF0qAxwtT9UBgS5/+6sU3mDh/69cL1bWBQqB9L88N/s3Oi+9E6DApKv9/4/r5gsMuzbLBiavgR/BVKk/xXFo6Q0MTFvR70khxDcwzivDP4i3c5VZV6nbtg+B4c5y+z7uzQPtV/TcKpohplabQdEdZg91kFO/3pIc+o9zpbl+Obabv6AaKVioL+dez3AcSLHg2jvrW7Yxd1GkAeel+ZEIRtgigEw7Y2kZwI3PCdNbQYQy4xcp2zTNRCYh+u78bt6WihNOJhg2iJf806swXOyn8Jxdr/pQexu2R82Kqa5xy7Fg025mxVL9B1uduTAPf6DHdfFaI+HWzYXAKCjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LmWQafndaiRJbkJ6IjsewlsJbGVfg8KF9P5WvcaQrc=;
 b=TzZpshdthvhbLxRKXF8IdKIAC5QjFZHnsa8Y9u7nHOJInEXp5TUOSsX6XWcH+W8U10XQxxE3IgQJPSdhF61xjTh1b8BvtDqV9nLHEPxMRrjFXSVXiM8s7VQ5VtQml5FzsSVkj64ysKzIMvVTsfN29VC8PykviBOBnid9k3FZvyLQeusBZg9CmhXHv9+jxnWrKAzkAgaSkFRtw01iNDdhOm7gv8KV0+okByjcrOA71dW4RKThVoLoUnPspaamsjkmWRCkVUFRQx+XrV2gjD0sEwg7WRQrtxZSVANo0uFZ2AGp9XH+9yciFKRNMTn5nS5eXCeaWC3Oa/W6BcBXf7ADpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sma.de; dmarc=pass action=none header.from=sma.de; dkim=pass
 header.d=sma.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sma.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LmWQafndaiRJbkJ6IjsewlsJbGVfg8KF9P5WvcaQrc=;
 b=gAX/YqaagW7P9NVxPStnpWtxA5DfWef8MQ2FnyAAuSQ+s3fQwgvKL3qSUG5p14vpLjlyj5Mt9GLDnHd4UwCKsGOgBdpMz0XzbSy4BPWgjCONnrY+N9Rq1yU7/gXI2ZgASQtayaOsc/bmQ/5w78ENHzViQC3YIv3TT1iqYv3AmQM=
Received: from AM0PR04MB6273.eurprd04.prod.outlook.com (2603:10a6:208:137::18)
 by AM0PR04MB5811.eurprd04.prod.outlook.com (2603:10a6:208:133::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 08:08:29 +0000
Received: from AM0PR04MB6273.eurprd04.prod.outlook.com
 ([fe80::d016:2e70:4030:4fdc]) by AM0PR04MB6273.eurprd04.prod.outlook.com
 ([fe80::d016:2e70:4030:4fdc%6]) with mapi id 15.20.3088.018; Wed, 10 Jun 2020
 08:08:29 +0000
From:   Felix Riemann <Felix.Riemann@sma.de>
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Andre Kalb <Andre.Kalb@sma.de>
Subject: RE: [PATCH] can: c_can: Handle lost bus-off interrupt while IRQs are
 disabled
Thread-Topic: [PATCH] can: c_can: Handle lost bus-off interrupt while IRQs are
 disabled
Thread-Index: AQHWA1tqGNdHGBlIIU2zdPpKElX6gKha4XMAgAAHV9CAAFzIgIAA8mwAgASDhoCAAKhIwIAumyKAgAAFPQCAQe+IcA==
Date:   Wed, 10 Jun 2020 08:08:28 +0000
Message-ID: <AM0PR04MB6273640802E04C4009CE5BC588830@AM0PR04MB6273.eurprd04.prod.outlook.com>
References: <20200326104318.15086-1-felix.riemann@sma.de>
 <20200326134015.GC27785@x1.vandijck-laurijssen.be>
 <AM0PR04MB5427D3BF64C3D3DA3961920488CF0@AM0PR04MB5427.eurprd04.prod.outlook.com>
 <20200326193837.GF760@x1.vandijck-laurijssen.be>
 <AM0PR04MB542742337A89900E12A8732288CC0@AM0PR04MB5427.eurprd04.prod.outlook.com>
 <20200330070203.GE22500@x1.vandijck-laurijssen.be>
 <AM0PR04MB54271EA5CC205263750BDBD288CB0@AM0PR04MB5427.eurprd04.prod.outlook.com>
 <20200429084733.GA27733@x1.vandijck-laurijssen.be>
 <20200429090618.GB27733@x1.vandijck-laurijssen.be>
In-Reply-To: <20200429090618.GB27733@x1.vandijck-laurijssen.be>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vandijck-laurijssen.be; dkim=none (message not signed)
 header.d=none;vandijck-laurijssen.be; dmarc=none action=none
 header.from=sma.de;
x-originating-ip: [93.209.171.127]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65e8af4b-9d01-4689-3297-08d80d15759e
x-ms-traffictypediagnostic: AM0PR04MB5811:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB58119220606AF856790B1EE488830@AM0PR04MB5811.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0430FA5CB7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QADwvkCLNc0TK1n2vKbF6CDTb1wcViW2l3rPW/a0yUCow/gtqYjaruGhwyqr4pGFmO76zKjkuKeAD4D9j2egMh5T9JlX72AXVQ/ygy6CKUz37U2urQPU02s2z0rgESXDCvYbOwGPoZaIHbf+pqYbfGadwoODjOX/ZWu2PlFvAdfnKdt0pRUPSTAUsxJHK/7O92zGDhMzXIE3hhHY1QdwkmwpvKrjjWXwEzkl6sxmGmRDZYS/jQkfLNd5Lb+mE3bK+rGHG18Fa+EBOL4wZppv+ixIjR3+WnPf99PqpN+VakfsdTR5gEcOseuLv6D74O3h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6273.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(55016002)(66446008)(52536014)(76116006)(2906002)(5660300002)(8676002)(86362001)(71200400001)(33656002)(8936002)(64756008)(186003)(7696005)(6506007)(478600001)(83380400001)(316002)(66476007)(54906003)(6916009)(53546011)(66946007)(4326008)(26005)(66556008)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: canF6ldAR9YCRn+Xv8rOufn0+zTmfT64Bi3IRA/waFeAltedYqkCpBc8H6YCSPbaIPiNVMtGzWDhDCAipuQXUitpMiEUy1JCcyLdylKg2EDAsxQ+a7hN5E6WCrHZ4IDRhDriBKTLAbrdJ5i86mSGAyRWLsMMJtzpm1JDa0vPocXAuxayvPBCy9l2/z9QDCWthay/aO7sqY6rTuTHXVC2BapXryRwMWoIeigPUp7aBOlqdygAwjJiJNfyz9b/WbvZvz18qGHTVlSIYCe3Oe6SU37jksWU5OffNmwElZbYaIK3luh04ljvBBYxOanxIXsYQ4kaIZOkt49bWbHNQPEoH2zrTVs+VmWvI9/JqjJgOXIQeDmR8b5cyDNGjG1/UPC77lD+n3q7hzzl9nCUPKe7cWFhzF3mIUT794OgHMg101ruza7ozybXyge9yoDeq5u6sW7eC4LcWoenlhsoA+lIFtY+kvVCzSxCnndCr6/u4PfKqOFr91tMppu8YQ6EM6+Y
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sma.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e8af4b-9d01-4689-3297-08d80d15759e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2020 08:08:29.0182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a059b96c-2829-4d11-8837-4cc1ff84735d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t9CtYkKwdnavlAJPBlCGzaw3BbPe+Yap1//zhIr8t8NXW1yRN/e4nd9U33HWP8wh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5811
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgS3VydCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdXJ0IFZh
biBEaWpjayA8ZGV2Lmt1cnRAdmFuZGlqY2stbGF1cmlqc3Nlbi5iZT4NCj4gU2VudDogV2VkbmVz
ZGF5LCBBcHJpbCAyOSwgMjAyMCAxMTowNiBBTQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjYW46
IGNfY2FuOiBIYW5kbGUgbG9zdCBidXMtb2ZmIGludGVycnVwdCB3aGlsZSBJUlFzIGFyZQ0KPiBk
aXNhYmxlZA0KPg0KPiBJIGhhdmUgdGhlIGltcHJlc3Npb24gdGhhdCB0aGUgcmVjdiBwYXRoIGlz
IGNvdmVyZWQsIGF0IGxlYXN0IHRoZSBudWxsIHB0ciB3b3VsZA0KPiBoYXZlIGNhdXNlZCBpc3N1
ZWQgZWFybGllciBhbHJlYWR5Lg0KPiBXb3VsZCB0aGUgcHJvYmxlbSBhcmlzZSBpbiBjX2Nhbl9k
b190eCBmZXRjaGluZyBhIE5VTEwgZWNob19za2I/DQoNCkl0IHJlYWxseSBsb29rcyBsaWtlIGl0
Lg0KDQpBZGRpbmcgYSBCVUdfT04gdG8gdGhlIGxvb3AgaW4gY19jYW5fZG9fdHggdHJpZ2dlcnMg
d2l0aCBhIE5VTEwgc2tiIHJldHVybmVkIGJ5IF9fY2FuX2dldF9lY2hvX3NrYigpLg0KDQpGb3Ig
dGVzdGluZyBJIHJlcGxhY2VkIHRoZSBCVUdfT04gd2l0aCBhIGNoZWNrIHRoYXQgc2tpcHMgdGhl
IHNrYiBpZiB0aGF0IGhhcHBlbnMgKG5vdCBzdXJlIGlmIHRoYXQgd291bGQgYmUgYSB2YWxpZCBm
aXggaW4gdGhhdCBwbGFjZSk6DQoNCndoaWxlICgob2JqID0gY19jYW5fZmZzNjQocGVuZCkpKSB7
DQpwZW5kICY9IH4oKHU2NCkxIDw8IChvYmogLSAxKSk7DQpjX2Nhbl9pbnZhbF90eF9vYmplY3Qo
ZGV2LCBJRl9SWCwgb2JqKTsNCmlkeCA9IG9iaiAtIHByaXYtPm9iai5zZW5kX2Zyc3Q7DQpza2Ig
PSBfX2Nhbl9nZXRfZWNob19za2IoZGV2LCBpZHgsICZsZW4pOw0KaWYoIXNrYikNCmNvbnRpbnVl
Ow0KY2FuX3J4X29mZmxvYWRfaXJxX3JlY2VpdmVfc2tiKCZwcml2LT5vZmZsb2FkLCBza2IpOw0K
Ynl0ZXMgKz0gbGVuOw0KcGt0cysrOw0KfQ0KDQpTbyBmYXIgaXQgZ290IHRocm91Z2ggdGhlIG5p
Z2h0IHdpdGhvdXQgY3Jhc2hpbmcgb3IgZGVhZGxvY2tpbmcsIGJ1dCBJIGNhbid0IHJlYWxseSB0
ZWxsIGlmIHdlIGFyZSBtaXNzaW5nIHBha2V0cyB0aG91Z2guDQoNClJlZ2FyZHMsDQoNCkZlbGl4
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg0K
U01BIFNvbGFyIFRlY2hub2xvZ3kgQUcNCkF1ZnNpY2h0c3JhdDogVXdlIEtsZWlua2F1ZiAoVm9y
c2l0emVuZGVyKQ0KVm9yc3RhbmQ6IFVscmljaCBIYWRkaW5nLCBEci4tSW5nLiBKdWVyZ2VuIFJl
aW5lcnQNCkhhbmRlbHNyZWdpc3RlcjogQW10c2dlcmljaHQgS2Fzc2VsIEhSQiAzOTcyDQpTaXR6
IGRlciBHZXNlbGxzY2hhZnQ6IDM0MjY2IE5pZXN0ZXRhbA0KVVN0LUlELU5yLiBERSAxMTMgMDgg
NTkgNTQNCldFRUUtUmVnLi1Oci4gREUgOTU4ODExNTANCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K

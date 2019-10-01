Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 218C8C3872
	for <lists+linux-can@lfdr.de>; Tue,  1 Oct 2019 17:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbfJAPD1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Oct 2019 11:03:27 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:44889 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfJAPD0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Oct 2019 11:03:26 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Thomas.Kopp@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Thomas.Kopp@microchip.com";
  x-sender="Thomas.Kopp@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Thomas.Kopp@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Thomas.Kopp@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: yDZHfvlc+N2gMyeRFyi0NKHh96Mh3hdqCdG9F7JxchIhJvTk/bIiAHLkqYFxZi2RMQau6bzdrR
 6yoO7YPzG8xv7IISIoseMNPuOYq2u5I9PldyjA4quhEkhNi+auyMnydRx69V0gZOjvRNFJbghL
 60gNs6vbjfl/VaQRSfvE2d2KykipaDIryIx2vJbbg2IvFjjPwiPYBuGNOpmhXyIC2Rci2lNeGn
 GlXIReBmVvaMx5eQg/kFrDBfg2ZFb0onMvxI7+YtXJhyCyrqubJJxWicxaD+uW5zabdeBPgAme
 sr8=
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="51265322"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2019 08:03:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 1 Oct 2019 08:03:12 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 1 Oct 2019 08:03:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6ck7uyE0Dkq95QYScEgcwTkIxro0UENbfdG1iNfhhASPLMItffzbfBYhRgr7OqfrBSfREJTGD/2JR5zF6FiIbDhU7sM6EaIz1BNc1LifeuFXRnohFHTjpo5rDPPoLmIpYRq+IDJ3BUkDA5ULgmaowqy4ZmoDfpfM5WHpExfBpb4/OyZlWkkU8JZjOVVrzUqnbse26ArjGfijRiymGJDOfWTkHya2jrPseRzJG2B9xOWcsezqx9YRBpS1XPjMiFloPSFTzPw8dZoEvjnZ2NXRkJ52Meh+DnWS/gYAOOkrjkqXq8bm1QXqSQEtSGE1j1OQA5VJh3ZAflsmmEcqujjnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBNLCkloqFUirGB2TQSscgGDvIdgsTD1zdaAsVmFpPU=;
 b=G3i7f2dVaB6aPYf+6AzMmlkgGbPB+t/b8/FWN9aDPwCE/5hM5wRLshbjFVtj4UGd7x6BfstHGu1Ex9GEfzG1QSfM+yq6M+trlpDx52nvrWgOh19QodHUVvHnEc9+b2v2J5c8ndWE0xNR+CJfblzNPR+6YN+ER+RX8VfB8aagi2C1OUP/vZ65LqXMPm4osxbm3REAwIRpfuVx1a/cad0Ceboyu6ZNa2aYGIty6/CGQrRW9QhHLSewFYD5+hehkPVPeYROth9PaF9nYO/LHtUNV8HZO7KYEDIkcpoKYprVPNR3QEnfX97OtDWGZqS3t+HO7bqzNwyMP8/TDgyJOEoZwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBNLCkloqFUirGB2TQSscgGDvIdgsTD1zdaAsVmFpPU=;
 b=dmfC34use8oCb4K9xtPKTACaDX4It6Z/F3n5jB+qTxoN59g+39rc3ZcAN6DHTfmEd6CjeO0Is2qmXMMOErTa4KvODjHKZW5KpvsFPkJjcKr0dNw6eBhmkcLUGLi2vkex/urLe3tcRIlOPtqpRdMgIrqjrzT/1I6EvkH59vL1j4Q=
Received: from MN2PR11MB3645.namprd11.prod.outlook.com (20.178.254.13) by
 MN2PR11MB4207.namprd11.prod.outlook.com (52.135.37.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Tue, 1 Oct 2019 15:03:09 +0000
Received: from MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::59b3:bc3a:7644:4bb7]) by MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::59b3:bc3a:7644:4bb7%5]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 15:03:09 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <mkl@pengutronix.de>, <linux-can@vger.kernel.org>
CC:     <martin@sperl.org>
Subject: RE: [PATCH] can: mcp25xxfd: fix register definitions, cleanup names
 to match DS
Thread-Topic: [PATCH] can: mcp25xxfd: fix register definitions, cleanup names
 to match DS
Thread-Index: AQHVdqUjF7hjphGu7UiinQOz6qXn8adF2hwAgAAJoZA=
Date:   Tue, 1 Oct 2019 15:03:09 +0000
Message-ID: <MN2PR11MB36455F34635586DDE2C1026FFB9D0@MN2PR11MB3645.namprd11.prod.outlook.com>
References: <20190929090543.438-1-thomas.kopp@microchip.com>
 <1ae4347d-1ffe-5106-38fd-511b9e5ff215@pengutronix.de>
In-Reply-To: <1ae4347d-1ffe-5106-38fd-511b9e5ff215@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [93.241.63.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d8166f2-7477-42d9-19ab-08d7468078fb
x-ms-traffictypediagnostic: MN2PR11MB4207:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MN2PR11MB42074FBA930F1B582945E600FB9D0@MN2PR11MB4207.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(376002)(136003)(189003)(199004)(66556008)(305945005)(66446008)(4326008)(6246003)(71190400001)(71200400001)(110136005)(8936002)(5660300002)(186003)(64756008)(316002)(81166006)(81156014)(8676002)(7696005)(6506007)(2906002)(74316002)(102836004)(52536014)(33656002)(66476007)(66946007)(7736002)(76116006)(76176011)(26005)(478600001)(14454004)(25786009)(229853002)(9686003)(3846002)(4744005)(66066001)(6116002)(966005)(476003)(11346002)(6436002)(256004)(99286004)(55016002)(6306002)(446003)(486006)(86362001)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4207;H:MN2PR11MB3645.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j3IQa7Kn+Rvpc9yOQJIEILAgr4tWIEpfiLf02+n2x/G0u6XlY5cr7I06lNIwNt/LtOjIHO1Z1MVNi+AZmLIlJbgPUVIwBT90XKLyH51/2MaUZtX6ZknMExLIpoSUhiR83Y8KLuJkPJVNQETq/EOAvYfYU8omwhpMstg3dGrPFlA8TuBDyR2zDwaW8agNdegBwPmkrxizohLdcNGuE4j5inAYIqQcn4EHI5zFhIcjSZRNZtZYishSrUM0adRS3l88BG2hv7TJYBbAfdlAc8FH0BG2NRyf40BMSc/rIEkLIk+AN0D9fix1kxD+EcN7EqY0j/qTruHRavTervKiWF8jkz8yQIF+K307ubX1mupQ9BCnBEQ0DNWYbdWss9MLERZ33JozhUEqATsYrO50/RNEvWnTm9FKIhlivcc/UeJNHLTwTAyMEQx84CEe9lRm1Xc2JA78bWH1xkdSK5tfsoX/6Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8166f2-7477-42d9-19ab-08d7468078fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 15:03:09.4635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h2lvnsGbzwAq8FV791E7n7Bs/eS6xO2IhUUeQT8hIljt4pS3JE3NxvzFUsqYZUOy8afpSF3u3Et9qH/1dWUzZRyGVjKzwHmvnBwjVRSnt94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4207
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiA+IEZpeGluZyBhIGNvdXBsZSBNQ1AyNXh4RkQgcmVnL2JpdCBkZWZpbml0aW9ucywgc3dpdGNo
aW5nIHRvIHRoZSBuYW1lcw0KPiB1c2VkIGluIHRoZSBEUy4NCj4gPiBQYXRjaCBpcyBhZ2FpbnN0
IHRoZSBsYXRlc3QgZnJvbSBNYXJ0aW4gU3BlcmwncyBnaXRodWINCj4gDQo+IFdoaWNoIG9uZSBp
cyB0aGUgbGF0ZXN0IGJyYW5jaD8NCg0KRnJvbSB3aGF0IEkndmUgc2VlbiBodHRwczovL2dpdGh1
Yi5jb20vbXNwZXJsL2xpbnV4LXJwaS90cmVlL3Vwc3RyZWFtLTUuMi1tYXN0ZXItODBmMjMtbWNw
MjV4eGZkLXY4LjIvZHJpdmVycy9uZXQvY2FuL3NwaSBzZWVtcyB0byBiZSB0aGUgbmV3ZXN0IGJy
YW5jaC4gRm9yIHRoZSBNQ1AyNXh4RkQgc3R1ZmYgdGhhdCBzZWVtcyB0byBiZSBvbiBwYXIgd2l0
aCBodHRwczovL2dpdGh1Yi5jb20vbXNwZXJsL2xpbnV4LXJwaS90cmVlL3JwaS00LjE5Lnktc3Bp
LWJjbTI4MzVhdXgrbWNwMjV4eGZkdjguMi9kcml2ZXJzL25ldC9jYW4vc3BpIA0KDQoNCkJlc3Qg
UmVnYXJkcywNClRob21hcw0K

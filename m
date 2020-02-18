Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6A071625B1
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2020 12:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgBRLox (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Feb 2020 06:44:53 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:35666 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgBRLox (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Feb 2020 06:44:53 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Thomas.Kopp@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Thomas.Kopp@microchip.com";
  x-sender="Thomas.Kopp@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Thomas.Kopp@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Thomas.Kopp@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: VZXe0YuEMn5mH5t4AMlwJs3kNrNsLIEMRd/oQLieddiZ3rNGqVuh7M/AgVK/HKJwo26QWcqO3K
 Ps8WgCBcvKsqjVTNb/Qjkfn/sjJCtffz/6bcyrU0JTXrufzweTGjf5y5JE8Flfy81qHJf3W+JM
 x8YEQM78pJuPwvP85/tFaS1UgzUhkz3hB9jgR6vBGDwO+k9HkcpjFN37gvKntuDWYPy62JSZNu
 9H93TsgQ/6de//wgqo3m3Dm+XQ+8/uFAW7//FMKCU/cI3Vn9DUc37IIsE/AZwDhVGAJXg3v9o5
 SBo=
X-IronPort-AV: E=Sophos;i="5.70,456,1574146800"; 
   d="scan'208";a="65835431"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Feb 2020 04:44:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 18 Feb 2020 04:44:51 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 18 Feb 2020 04:44:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdMGnNRAVJgG4N8yE6fIx5MiAhprkQBYQlTlwZgnpNDGaLlC7d1xNJRt0EFmscDB6FXyK1/isdObZimqLVZsbVi9p2pDnHefvnnl3n51d26aEOWfQhhiFh84VhzRjb4efC1gMFJ+6NqQFRQH5CXnMXAVYMFzoAPZAarMYHnN/9Md4POd0KtovKQ54FUw3SH5maL26TMtrGwCL0uI7zCgRPwhSCM2Y16t6yitIGDxg5Jvm8aR1cO9MClJcHisB2gkVFhyI9aTLEDhISS/YnnZ82xMw1aL/v/+pAQN1wvex1a9tVwfqVniiC7QrmSQ1cbAnEngg4QeC/NG0ON4t7drTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4l4DlTYPyHwaLiWjzl/UMvUb11m7fJ+T0Dr6E/bOhI=;
 b=HQVwuk5m8tH1aVCzkjbhYgtKmY43qyeimnIp+blkFyOR5fklnVfmH5gNS7ZUl38ufCyI2Qb9VNUW9vbVIjtxa77DyBbR6SSEIzaijgJnT4pFbrxmogRW60K6fenUe33W6436qKWN/0ZZLZTy5gaU5kHFKeIZZCzEyMz2I8fgoPxQ9tv9dUsieCNWN5drcydE8vTqoCUdrjwGeHEPOeaHCXMdvlBPObOOKyBm4r/qOCNqBnxZVy3eZidrDs3UiR9Dh/4S6IVPINQ8d+D/EbzeaWxRDFmrdQ0w/WCht909TgsfIgYtk1r6PmDYnnfzvwZgmqn9SiDe9WNoZZZkz3hCtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4l4DlTYPyHwaLiWjzl/UMvUb11m7fJ+T0Dr6E/bOhI=;
 b=QZ/qdFx72nhkA2h2TeOQRsEQvoF4eQrRsIxptE2TAZ+QoM5/uMqP+bkYYf4wP9imuufejHAgSTT+o0PL2gCbkQjX41UFy5uLXVx4QsTEvhFoJsU1P5RltvhZ90xUeykOXXr8mPy3KGQ86+GTmMXrEK5YIM50VgheRXkU0bX7w6c=
Received: from MN2PR11MB3645.namprd11.prod.outlook.com (20.178.254.13) by
 MN2PR11MB3776.namprd11.prod.outlook.com (20.178.251.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Tue, 18 Feb 2020 11:44:50 +0000
Received: from MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::98d2:cf68:f0fc:501c]) by MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::98d2:cf68:f0fc:501c%7]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 11:44:50 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <mkl@pengutronix.de>, <linux-can@vger.kernel.org>
Subject: RE: mcp25xxfd: missing cerrif
Thread-Topic: mcp25xxfd: missing cerrif
Thread-Index: AQHV4NpbFcBokjWjJkKD+9lAnrPjz6gV/F+wgAAGqgCAAUzHcIADbHyAgAX2EhA=
Date:   Tue, 18 Feb 2020 11:44:49 +0000
Message-ID: <MN2PR11MB3645382ACDDB3CF132B92E25FB110@MN2PR11MB3645.namprd11.prod.outlook.com>
References: <a933c5be-c95f-36d5-57ce-c312fbaa81db@pengutronix.de>
 <MN2PR11MB36450B9C2BE91F6CBA897002FB180@MN2PR11MB3645.namprd11.prod.outlook.com>
 <532b4fed-a984-0875-d933-43c6a90fcc1a@pengutronix.de>
 <MN2PR11MB36458E1696285A0196B6E46FFB1B0@MN2PR11MB3645.namprd11.prod.outlook.com>
 <a049ea8b-a3e2-ea39-d084-bd12b637cb9c@pengutronix.de>
In-Reply-To: <a049ea8b-a3e2-ea39-d084-bd12b637cb9c@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [93.241.63.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47d1f68f-054a-4219-603b-08d7b467f62f
x-ms-traffictypediagnostic: MN2PR11MB3776:
x-microsoft-antispam-prvs: <MN2PR11MB37767AB50021C2D3C5728B33FB110@MN2PR11MB3776.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:483;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(376002)(396003)(366004)(199004)(189003)(8936002)(66946007)(8676002)(66446008)(66556008)(76116006)(110136005)(66476007)(64756008)(81166006)(33656002)(5660300002)(81156014)(9686003)(2906002)(71200400001)(316002)(7696005)(6506007)(26005)(52536014)(478600001)(186003)(86362001)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3776;H:MN2PR11MB3645.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M2yke+boSBxrBks5rBE4V0BQgVXyr/xMdyGzl7ToWp0njsWJgbcAfASj1YNg0AfQX3myaMW2CUk7AP+YKsOj1ywcFSDWxDvZrHccR8kn+o1Q/cpgsltwLkRt3UZSYbrpLs3wua6ctN6EE5Bxqk6dcF4B34VDZWT+/V8VU31lZQoDhJ8Uu7ChIr6NtF/8FzgnPfHMI4VGWN1TbZ3Aw6a1+FMsJGN1wg/1HwPYEeYJr5rpp025ErR4sipSeb8bZGni96fPU6rZ69Lj5AcUNud08r06CBf13ZuFGON/Mr53HGfARqePzeEWem5O/EoWEHUcADd60Tze4Ct13qYRflqc+iGySM7b3ib8u4VbzFmKopL6cGQI8IIDhpfooo97192NEP1kzoLj2fKtvOUKW2JAbxIUJtrOzJ5tKqF9YDnEJOcfAH6jDQp4AOFJd1vzhwdE
x-ms-exchange-antispam-messagedata: M/rv8KuU/bvArvLGkvdKx40Klqr2jHm/44Bm3Es6VBSxJT5Ep+an11tzulIoAT3n6SaFugXsnBEISjrG6wn3Q7ADAmxwvdPKLkLaLrFAtv33BkpA4/EusYiKFGZJgfln/9vRhJqzW3PIoUToASalWQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d1f68f-054a-4219-603b-08d7b467f62f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 11:44:49.8697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fk2V/Tugr+aqUHXrRon5HJVddLvjBC0Da4+xksLbOiHkEWjrxnbofcYcypx8S+cTq/xAnLLZfTE5Sqx3H+gv+Gi4PAGe/sG1gUZkd5OQOw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3776
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiBIbW1tLiBJIHRoaW5rIHRoZSBxdWVzdGlvbiBpcywgaXMgdGhlcmUgYSBkZWRpY2F0ZWQgd2Fy
bmluZyBzdGF0ZSBhbmQNCj4gaWYsIGhvdyBhcmUgdGhlIHRyYW5zaXRpb25zIGZyb20gYW5kIHRv
IGl0Pw0KSSB0aGluayB0aGUgbWFpbiBjb25mdXNpb24gY29tZXMgZnJvbSB0aGUgZmFjdCB0aGF0
IGVycm9yIHdhcm5pbmcgaXMgbm90IGEgc3RhdGUgYXMgZGVmaW5lZCBpbiB0aGUgSVNPLiBUaGUg
SVNPIGRlZmluZXMgdGhyZWUgc3RhdGVzOiBlcnJvci1hY3RpdmUsIGVycm9yLXBhc3NpdmUgYW5k
IGJ1cy1vZmYuDQpUaGUgZXJyb3Igd2FybmluZyBpcyBhbiBpbnRlcnJ1cHQgdGhhdCAobW9zdD8p
IENBTiBJUHMgaXNzdWUgd2hlbiB0aGUgZXJyb3IgY291bnRlcnMgZXhjZWVkcyA5Ni4gQUZBSUsg
dGhpcyBpcyBvbmx5IGEgY29udmVudGlvbiB0aG91Z2gsIG5vdCBhIHNwZWMgKEkga25vdyB0aGF0
IEt2YXNlciBhbmQgdGhlIEJvc2NoIE1DQU4gaGFuZGxlIGl0IGxpa2UgdGhpcykuDQoNCj4gQUNL
LiBUaGUgZG9jdW1lbnRhdGlvbiB0YWxrcyBhYm91dCBlcnJvciBwYXNzaXZlIHRvIGVycm9yIGFj
dGl2ZSwgd2hpY2gNCj4gbWVhbnMgdGhlIGRpYWdyYW0gbG9va3MgbGlrZSB0aGlzOg0KTm90IHF1
aXRlLCB0aGF0J3MgaG93IGl0IHNob3VsZCBsb29rIGxpa2U6DQogICAgICAgICAgICAgICAgICAg
ICAtLSBFID4gOTUgLS0gICAgICAgICAtLSBFID4gMTI3IC0tICAgICAgICAgICAgICAgLS0gRSA+
IDI1NSAtLQ0KICAgICAgICAgICAgICAgICAgICAgIC8gICAgICAgICAgICBcICAgICAgICAgIC8g
ICAgICAgICAgICAgXCAgICAgICAgICAgICAgICAgICAgLyAgICAgICAgICAgICBcDQogICAgICAg
ICAgICAgICAgICAgIC8gICAgICAgICAgICAgIFYgICAgICAgICAvICAgICAgICAgICAgICAgViAg
ICAgICAgICAgICAgICAvICAgICAgICAgICAgICAgVg0KIC0tPiBlcnJvciBhY3RpdmUgIChlcnJv
ciB3YXJuaW5nKSAgICAgIGVycm9yIHBhc3NpdmUgICAgYnVzIG9mZg0KICAgICAgICAgICBeICAg
ICAgICAgICAgICAvICAgICAgICAgICAgICAgICAgICAgIF4gICAgICAgICAvDQogICAgICAgICAg
ICBcICAgICAgICAgICAgLyAgICAgICAgICAgICAgICAgICAgICAgICBcICAgICAgIC8NCiAgICAg
ICAgICAgICAtLSBFIDwgOTYgLS0gICAgICAgICAgICAgICAgICAgLS0gRSA8IDEyOCAtLQ0KDQpU
aGUgZW51bSBpbiBuZXRsaW5rLmggbWl4ZXMgdGhlIGVycm9yIHN0YXRlcyBwbHVzIHNvbWUgb3Ro
ZXIgc3RhdGVzLiBUbyBmdWxmaWxsIHRoZSBJU08gYW4gaW50ZXJydXB0IGZyb20gRXJyb3Igd2Fy
bmluZyB0byBFcnJvciBhY3RpdmUgaXNuJ3QgcmVhbGx5IHVzZWZ1bC4gSSBzdXBwb3NlIHRoYXQn
cyB3aHkgaXQncyBub3QgaW1wbGVtZW50ZWQgaW4gdGhlIE1DUDI1MThGRC4NCg0KZW51bSBjYW5f
c3RhdGUgew0KCUNBTl9TVEFURV9FUlJPUl9BQ1RJVkUgPSAwLAkvKiBSWC9UWCBlcnJvciBjb3Vu
dCA8IDk2ICovDQoJQ0FOX1NUQVRFX0VSUk9SX1dBUk5JTkcsCS8qIFJYL1RYIGVycm9yIGNvdW50
IDwgMTI4ICovDQoJQ0FOX1NUQVRFX0VSUk9SX1BBU1NJVkUsCS8qIFJYL1RYIGVycm9yIGNvdW50
IDwgMjU2ICovDQoJQ0FOX1NUQVRFX0JVU19PRkYsCQkvKiBSWC9UWCBlcnJvciBjb3VudCA+PSAy
NTYgKi8NCglDQU5fU1RBVEVfU1RPUFBFRCwJCS8qIERldmljZSBpcyBzdG9wcGVkICovDQoJQ0FO
X1NUQVRFX1NMRUVQSU5HLAkJLyogRGV2aWNlIGlzIHNsZWVwaW5nICovDQoJQ0FOX1NUQVRFX01B
WA0KfTsNCg0KUXVpY2tseSBsb29raW5nIGF0IGRpZmZlcmVudCBDQU4gZHJpdmVycyBpbiB0aGUg
a2VybmVsIEkgZG9uJ3QgcmVhbGx5IHNlZSBhIGNvbW1vbiBwYXR0ZXJuIGhvdyB0aGlzIGNvdW50
ZXIgaXMgdXNlZC4NClRha2luZyB0aGUgTV9DQU4gZHJpdmVyIGFzIGFuIGV4YW1wbGUgKGRyaXZl
cnMvbmV0L2Nhbi9tX2Nhbi9tX2Nhbi5jI0w2NzEpIEkgc2VlIHRoYXQgYSBzdGF0ZSBjaGFuZ2Ug
ZnJvbSBlcnJvciBwYXNzaXZlIHRvIGVycm9yIGFjdGl2ZSAod2l0aCB0aGUgZXJyb3Igd2Fybmlu
ZyBiaXQgYmVpbmcgc2V0KSBsZWFkcyB0byB0aGUgZXJyb3Igd2FybmluZyBjb3VudGVyIGJlaW5n
IGluY3JlbWVudGVkIGFuZCB0aGUgc3RhdGUgYmVpbmcgdXBkYXRlZCB0byBDQU5fU1RBVEVfRVJS
T1JfV0FSTklORy4NCkkgZGlkIG5vdCBmaW5kIGEgZG9jdW1lbnRhdGlvbiBvbiB3aGF0IHRoaXMg
ZXJyb3IgY291bnRlciBpcyBzdXBwb3NlZCB0byBzaG93IC0gSSBzdXBwb3NlIEkgZGlkbid0IGxv
b2sgaW4gdGhlIHJpZ2h0IHBsYWNlLiBCdXQgd2hpbGUgdGhlIG51bWJlciBvZiB0aW1lcyB0aGUg
ZGV2aWNlIHdhcyBpbiBlcnJvciB3YXJuaW5nIHN0YXRlIGhhcyB0ZWNobmljYWxseSBnb25lIHVw
IGJ5IG9uZSBJIHdvdWxkIGhhdmUgZXhwZWN0ZWQgdGhhdCB0aGlzIGNvdW50cyB0aGUgc3dpdGNo
ZXMuIEFnYWluLCB0aGlzIGlzIG5vdCBiYXNlZCBvbiBkb2N1bWVudGF0aW9uIChJJ20gbm90IHJl
YWxseSBmYW1pbGlhciB3aXRoIHRoZSBTb2NrZXRDQU4gc28gaXQncyBsaWtlbHkgSSBtaXNzZWQg
c29tZXRoaW5nKSBidXQgcmF0aGVyIG9uIHdoYXQgSSB3b3VsZCBoYXZlIGV4cGVjdGVkIGludHVp
dGl2ZWx5Lg0KDQpPbmUgbW9yZSB0aGluZyBJIG5vdGljZWQgaW4gdGhlIG1jYW4gZHJpdmVyIGlz
IHRoYXQgdGhlcmUgZG9lc24ndCBzZWVtIHRvIGJlIGEgd2F5IHRvIGdvIGZyb20gZXJyb3Igd2Fy
bmluZyB0byBlcnJvciBhY3RpdmUgd2l0aG91dCBpZmRvd24vaWZ1cC4gU28gdGhlIGRyaXZlciBy
ZW1haW5zIGluIGluIGVycm9yIHdhcm5pbmcgc3RhdGUgZm9yIGEgc2lnbmlmaWNhbnQgdGltZS4N
Cg0KQW5vdGhlciBleGFtcGxlIGluIHRoZSBrdmFzZXJfdXNiX2h5ZHJhLmM6DQogKiBLbm93biBp
c3N1ZXM6DQogKiAgLSBUcmFuc2l0aW9uIGZyb20gQ0FOX1NUQVRFX0VSUk9SX1dBUk5JTkcgdG8g
Q0FOX1NUQVRFX0VSUk9SX0FDVElWRSBpcyBvbmx5DQogKiAgICByZXBvcnRlZCBhZnRlciBhIGNh
bGwgdG8gZG9fZ2V0X2JlcnJfY291bnRlcigpLCBzaW5jZSBmaXJtd2FyZSBkb2VzIG5vdA0KICog
ICAgZGlzdGluZ3Vpc2ggYmV0d2VlbiBFUlJPUl9XQVJOSU5HIGFuZCBFUlJPUl9BQ1RJVkUuDQoN
Cj4gSSB0aGluayB3ZSBoYXZlIHRvIGRpc2N1c3MgaG93IHRoZSBzdGF0ZSBkaWFncmFtIG9uIHNv
Y2tldGNhbiBzaG91bGQNCj5sb29rIGxpa2UuDQoNCkkgYWdyZWUuIEhvdyB3b3VsZCB0aGF0IGRp
c2N1c3Npb24gaGFwcGVuPw0KDQpCZXN0IFJlZ2FyZHMsDQpUaG9tYXMgDQoNCg==

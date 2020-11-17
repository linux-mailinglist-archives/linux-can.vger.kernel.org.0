Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCBE2B68AD
	for <lists+linux-can@lfdr.de>; Tue, 17 Nov 2020 16:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgKQP21 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 Nov 2020 10:28:27 -0500
Received: from de-out1.bosch-org.com ([139.15.230.186]:46536 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbgKQP21 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 Nov 2020 10:28:27 -0500
X-Greylist: delayed 2586 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Nov 2020 10:28:25 EST
Received: from si0vm1947.rbesz01.com (lb41g3-ha-dmz-psi-sl1-mailout.fe.ssn.bosch.com [139.15.230.188])
        by fe0vms0187.rbdmz01.com (Postfix) with ESMTPS id 4Cb8wS4fvYz1XLDR9;
        Tue, 17 Nov 2020 16:28:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=key2-intmail; t=1605626904;
        bh=OEO3R3OyQ/MyfwEOo1aKgZ7O31m4QfepUJyJQGtUuDU=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=gWHgRA825oogKcEeJJTbex6HsfqRHbo4bWX6PERe3UQTkTaI9KndPYFAA0MNLGWVL
         cB3rYaMUgrstgOaML7CL9FskrcadH34wYMmsxWZNp5azF7Sk3kuw7Zl7Zyc0nsP5+P
         wJWEISc8Hzqh+zppmFX95E2hOeaKTDOe/agrXMj8=
Received: from fe0vm1741.rbesz01.com (unknown [10.58.172.176])
        by si0vm1947.rbesz01.com (Postfix) with ESMTPS id 4Cb8wS4L0sz6CjSs7;
        Tue, 17 Nov 2020 16:28:24 +0100 (CET)
X-AuditID: 0a3aad15-f9dff700000022e8-47-5fb3ec181b67
Received: from fe0vm1652.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm1741.rbesz01.com (SMG Outbound) with SMTP id 2F.AC.08936.81CE3BF5; Tue, 17 Nov 2020 16:28:24 +0100 (CET)
Received: from FE-MBX2035.de.bosch.com (fe-mbx2035.de.bosch.com [10.3.231.45])
        by fe0vm1652.rbesz01.com (Postfix) with ESMTPS id 4Cb8wS2TpnzB1J;
        Tue, 17 Nov 2020 16:28:24 +0100 (CET)
Received: from SGPMBX2018.APAC.bosch.com (10.187.83.36) by
 FE-MBX2035.de.bosch.com (10.3.231.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 17 Nov 2020 16:28:23 +0100
Received: from FE-MBX2051.de.bosch.com (10.3.231.61) by
 SGPMBX2018.APAC.bosch.com (10.187.83.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 17 Nov 2020 23:28:21 +0800
Received: from FE-MBX2051.de.bosch.com ([fe80::9402:faf1:5852:4e2f]) by
 FE-MBX2051.de.bosch.com ([fe80::9402:faf1:5852:4e2f%6]) with mapi id
 15.01.2106.004; Tue, 17 Nov 2020 16:28:19 +0100
From:   "Jonas Mark (BT-FIR/ENG1-Grb)" <Mark.Jonas@de.bosch.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "WANG Xin (BT-FIR/ENG1-Zhu)" <Xin.Wang7@cn.bosch.com>
Subject: AW: [PATCH] Fix attribute list size in do_get_nl_link()
Thread-Topic: [PATCH] Fix attribute list size in do_get_nl_link()
Thread-Index: AQHWvPBEZZmCtUZC6UWK+ezQ/N9DHanMWHsAgAATkxA=
Date:   Tue, 17 Nov 2020 15:28:19 +0000
Message-ID: <a2a1b05307604f1cb9ecb1245b4bc3a0@de.bosch.com>
References: <20201117144222.7809-1-mark.jonas@de.bosch.com>
 <0285bc2b-dc7a-3fcb-3bc8-061e8e8e5bd5@pengutronix.de>
In-Reply-To: <0285bc2b-dc7a-3fcb-3bc8-061e8e8e5bd5@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.143.165.147]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsXCZbVWVlfizeZ4gyMrJS1WfZ/KbLF+0RQW
        ByaP/r8GHp83yQUwRXHZpKTmZJalFunbJXBl/Nx5k7ngGE/Fxc9PmRsY5/B0MXJySAiYSMyf
        9p21i5GLQ0hgOpPExH3NUM4uRolZt26xQzgfGCVWPf6H4Fw5uIYRwjnAKHHkSSs7yDA2ATuJ
        /a/fMIHYIgJaErc/bmfrYuTgYBYokVi/pxIkLCzgIHFj4zpGiBJHidnbj0DZVhLt666CjWER
        UJX4cPIRmM0rYC2x6/IzVpAxQgLFEl8e5IKYnAJOEq9+CoFUMArISmzYcJ4ZxGYWEJfY9Azk
        G5DPBCSW7IGISwiISrx8/A8qriTx8M9mZojDNCXW79KHaFWUmNL9EGqpoMTJmU9YJgBDAMnU
        WQgds5B0zELSsYCRZRWjaFqqQVmuobmJoV5RUmpxlYGhXnJ+7iZGSKSJ7mC80/1B7xAjEwfj
        IUYJDmYlEV4Xk43xQrwpiZVVqUX58UWlOanFhxilOViUxHlVeDbGCQmkJ5akZqemFqQWwWSZ
        ODilGpjOTTnBaxzWmy1X6HJQvujV7enWsbt3zpF2u/V3KY9+3Tm11JhJ1v91TbXySo73Cedf
        Ut0228qBwbpEmtnY60hNRPvx6F6teo5V/j6rQ9SPKqVXX+G+zvajf3ZNC/cC5S3Fjrt/rb9y
        7vauu4rtq7PnxEe/Fjj2myP6zuVNsSWVxxI/TIs1UVkz487Opd9Sr3vH/58c3NSnUMA+T15P
        5YmLTZbEptSQfQJKHzc+EfnVrftRYGr9rVmpvW83qntVtHabHHg911pgwlPJl3IeeW2tsa2t
        V4qS3dRPdmrunm/LtctIuXH6BSYLcV6RaSFnJS5xcsc0nE0pVw/Xy8p1+GBeHnP/rPyElteP
        Uw8vV2Ipzkg01GIuKk4EANDU9tAjAwAA
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgTWFyYywNCg0KPiBPbiAxMS8xNy8yMCAzOjQyIFBNLCBNYXJrIEpvbmFzIHdyb3RlOg0KPiA+
IEZyb206IFdhbmcgWGluIDx4aW4ud2FuZzdAY24uYm9zY2guY29tPg0KPiA+DQo+ID4gVGhlIGZ1
bmN0aW9uIGRvX2dldF9ubF9saW5rKCkgcmV0cmlldmVzIGF0dHJpYnV0ZXMgZnJvbSB0aGUgcmVz
cG9uc2UNCj4gPiBSVE1fTkVXTElOSy4gQnV0IGl0IGNhbGN1bGF0ZXMgdGhlIGF0dHJpYnV0ZSBs
aXN0IHNpemUgd2l0aCB0aGUgd3JvbmcNCj4gPiBzdHJ1Y3R1cmUgc3RydWN0IGlmYWRkcm1zZy4g
QWNjb3JkaW5nIHRvIG1hbiA3IHJ0bmV0bGluaywgUlRNX05FV0xJTksNCj4gPiBtZXNzYWdlIHVz
ZXMgc3RydWN0IGlmaW5mb21zZyBpbnN0ZWFkIG9mIHN0cnVjdCBpZmFkZHJtc2cuICBUaGlzDQo+
ID4gY2F1c2VzIHRoYXQgYWRkaXRpb25hbCA4IGJ5dGVzIGFyZSBwYXJzZWQgYW5kIGdhcmJhZ2Ug
YXR0cmlidXRlcyBtaWdodA0KPiA+IGJlIHJldHJpZXZlZC4gT25lIG9mIGNvbnNlcXVlbmNlcyBp
cyB0aGF0IHRoZSBtZXNzYWdlIHdpbGwgYmUgZHJvcHBlZA0KPiA+IGlmIHRoZSBnYXJiYWdlIGF0
dHJpYnV0ZSBpcyBJRkxBX0lGTkFNRSBhbmQgY29udGFpbnMgYW4gaW52YWxpZA0KPiA+IGludGVy
ZmFjZSBuYW1lLg0KPiA+DQo+ID4gVG8gZml4IHRoaXMgaXNzdWUsIHVzZSBzdHJ1Y3QgaWZpbmZv
bXNnIHRvIGNhbGN1bGF0ZSB0aGUgc2l6ZSBvZg0KPiA+IGF0dHJpYnV0ZSBsaXN0IGZvciBSVE1f
TkVXTElOSy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdhbmcgWGluIDx4aW4ud2FuZzdAY24u
Ym9zY2guY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmsgSm9uYXMgPG1hcmsuam9uYXNAZGUu
Ym9zY2guY29tPg0KPiANCj4gQXBwbGllZCB0byBtYXN0ZXIuDQoNCkkgcGxhbiB0byBlaXRoZXIg
YWRkIHRoZSBwYXRjaCB0byB0aGUgbGlic29ja2V0Y2FuIHJlY2lwZSBpbiBtZXRhLW9wZW5lbWJl
ZGRlZA0Kb3IgdG8gdXBncmFkZSB0aGUgcmVjaXBlIHRvIGEgbmV3IHZlcnNpb24gb2YgbGlic29j
a2V0Y2FuLiBJIHdvdWxkIHByZWZlcg0KdXBncmFkaW5nIHRoZSByZWNpcGUgdG8gYSBuZXcgdmVy
c2lvbi4NCg0KRG8geW91IHBsYW4gdG8gcmVsZWFzZSBhIG5ldyB2ZXJzaW9uIG9mIGxpYnNvY2tl
dGNhbiBzb29uPw0KDQpHcmVldGluZ3MsDQpNYXJrDQo=

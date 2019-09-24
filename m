Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6403BD1F7
	for <lists+linux-can@lfdr.de>; Tue, 24 Sep 2019 20:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436859AbfIXSp3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 24 Sep 2019 14:45:29 -0400
Received: from mail-eopbgr150097.outbound.protection.outlook.com ([40.107.15.97]:34486
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390679AbfIXSp2 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 24 Sep 2019 14:45:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mo3Wyn0bjcJ7+FO+4gqv6ElqQfR8lu/TOtkCCcdMrB6Fcz/EjM2BGmGMRCppKgl9n9xJF5tG3g9gbpzsuT0SYfIVge64kPdYbbSS8JaltVryXWu+BqQMDk7hQ1+wLp4dNawCEJ/pn0TKM9W7PpmmQjPe+u6evJ9+HIbxitBILCjy4v/D5e6kCsu2pyeUOG10Xe5RcyBaQgrzsTyJyVMoJy9NL68a6avq/D05HhXR5wALAUNvdELVTI1otMqrj3nXg7aYFZC4idzMzzdqGDNqD62Quy6xi9kxmf52yloV51JCJ3Wy9eRj0U8GfkIWKbWLU+jYRetregHxgIZi8ETtnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaizSe+C6hvEna3q9PoBwASfz50Cw+HVSdq6f3prdw4=;
 b=DQjBRJEOmb3Oc8gN42peXK95YmSBsftfpNdx0RKPab/W/UlboXChzM4Fpo4gAFRn33WFitnmYHj90pamVWl3cusRWzdqpnsyLKXG/frS+2gaGrtstEcV7HRb+AS5OUjF9iMyVIJMVgQqj2HCxAkvHX2rVe0/qAlt/Q9RDSV/iXPm27MJ/6Pcik4D3EmK4SPcnd4zeYf4C0R57Mn8ObluLjHIDU2JlR5hln/YJJZaunT5+Zmpqpll0PrXuxBhRzAISNhLmuwJxTYwSkwUE8MeKjKQcyyrckGZwy3o+wHgBXTccrBmqJt+cHc2htOJjluav6a8L48yfn4Qxqxa2twH0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaizSe+C6hvEna3q9PoBwASfz50Cw+HVSdq6f3prdw4=;
 b=fIXs05mukHVD2Gqe95yiZsMSZQvJWoNl27kiKTuO7/pAqvv9NqG4dNh0MGeQBhuJqU6nO10bERdhsRw+xubJ04EBQlcCyvWKmqYlBHdliQoq+ot2sWkMaNpeW9SUWgC6iXFGJOLhx7TxmSHgIQVLPE2C9pHShotRrEoUGE/K43w=
Received: from VI1PR0701MB2623.eurprd07.prod.outlook.com (10.173.82.19) by
 VI1PR0701MB2847.eurprd07.prod.outlook.com (10.173.70.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Tue, 24 Sep 2019 18:45:25 +0000
Received: from VI1PR0701MB2623.eurprd07.prod.outlook.com
 ([fe80::dc92:2e0d:561a:fbb1]) by VI1PR0701MB2623.eurprd07.prod.outlook.com
 ([fe80::dc92:2e0d:561a:fbb1%8]) with mapi id 15.20.2305.013; Tue, 24 Sep 2019
 18:45:25 +0000
From:   Jeroen Hofstee <jhofstee@victronenergy.com>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: [PATCH 0/7] can: ti_hecc changes
Thread-Topic: [PATCH 0/7] can: ti_hecc changes
Thread-Index: AQHVcwg6BSrribc3JkGUBFOahCqBrg==
Date:   Tue, 24 Sep 2019 18:45:25 +0000
Message-ID: <20190924184437.10607-1-jhofstee@victronenergy.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:1c01:3bc5:4e00:c415:8ca2:43df:451e]
x-clientproxiedby: AM0PR05CA0052.eurprd05.prod.outlook.com
 (2603:10a6:208:be::29) To VI1PR0701MB2623.eurprd07.prod.outlook.com
 (2603:10a6:801:b::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jhofstee@victronenergy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ace8e890-b425-4305-f61b-08d7411f5c99
x-ms-traffictypediagnostic: VI1PR0701MB2847:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0701MB2847CE2C6ABA5C124FA8A8EAC0840@VI1PR0701MB2847.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(39850400004)(346002)(136003)(396003)(189003)(199004)(81156014)(86362001)(2906002)(2351001)(14454004)(305945005)(478600001)(8676002)(2501003)(36756003)(7736002)(6116002)(25786009)(8936002)(50226002)(81166006)(46003)(66476007)(6506007)(6916009)(102836004)(186003)(2616005)(1076003)(6486002)(66946007)(64756008)(486006)(476003)(66556008)(66446008)(5660300002)(71200400001)(71190400001)(5640700003)(6436002)(52116002)(386003)(4326008)(256004)(316002)(99286004)(107886003)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0701MB2847;H:VI1PR0701MB2623.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: victronenergy.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J7kXCHl/3CGKWnPLLT9HLDRU0931Kugs3lD5EQ8ZhFT/1QLRhtw9ko/B/Z4pxADqJC5hfAjTv/phPkGwRry1Qp6gahfoPwiVg1FNjaDbgA0IFkUoigDnOfpZWTzkGJHFDGgGWL9DoAYYpwIicgb02pwjPKUzdETSchh4XkZQ5rEJIj+3bpZiplqJ66UjLXtO3qB8z2ynKa+TW8X9m2wAR3iyC059lg+4a4oTiN3Y6xJh3SJBeE57nHhUB+Wr1Gv7HGdD3125CkH8+FdNpOYE7eldGso6vMmK2QXzYr+JemFEfGdRLZwOC/+Zp4hrNYJy6z66N81S2CHZWjwI5dPOwXedTCzESlYeNsaUbmCqCckvUmCg8LdzSq25n+CGsTWShc6msy3s/grMFRhCdiKEBajARGzh35GjZEeSgxpI45c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace8e890-b425-4305-f61b-08d7411f5c99
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 18:45:25.1639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +mgtlV6vJ/vbL37GrTFBi2pDV+q0qbQPstDJ1fys/+BcTXHfLloKdzsJAnBMFq4OwPEhtruBuOppaUmr7iRC381COhPwocuCOf45OxHFVEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB2847
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

* Marc Kleine-Budde suggested to release the rx mailboxes a bit earlier,
  that is included here. It is preceded by a small change in rx-offload
  to make it clear that all mailboxes are read. It is not a functional
  change.
* The CAN protocol kernel (CPK) should be stopped when the interface
  goes down.
* The tx path has a (harmless) race for HECC_CANMIM. Just keep it set.
* The interface state keeping can lack resulting in wrong interface states,
  the state is now based on the interrupt flags and are updated directly.
* The driver lacked a manner to lower the state again. This is added
  based on the error counters.

Jeroen Hofstee (7):
  can: rx-offload: continue on error
  can: ti_hecc: release the mailbox a bit earlier
  can: ti_hecc: stop the CPK on down
  can: ti_hecc: keep MIM and MD set
  can: ti_hecc: add fifo underflow error reporting
  can: ti_hecc: properly report state changes
  can: ti_hecc: add missing state changes

 drivers/net/can/rx-offload.c |   2 +-
 drivers/net/can/ti_hecc.c    | 208 +++++++++++++++++++++--------------
 2 files changed, 126 insertions(+), 84 deletions(-)

--=20
2.17.1


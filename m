Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D522DBEEF
	for <lists+linux-can@lfdr.de>; Wed, 16 Dec 2020 11:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgLPKot (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Dec 2020 05:44:49 -0500
Received: from mail-eopbgr30131.outbound.protection.outlook.com ([40.107.3.131]:24737
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbgLPKot (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 16 Dec 2020 05:44:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3ZWn7RZQSayaN6f4eqfxVZ4F3Yu9hsN/lu/DZ3nTyXEpBy251tzoxjh5ePv0GQuelpOIXIx2lVz/bX9GUQ9T/VX4yepr/91biDRlJA+4uF8Q80D6JNE9hhOL6c3qGwq2yeDwN/3zYDl59sJC54h7B8S3cDqKqyPZH5VStn+6dzgAGBNFmXeeIBOO62+2kserSz8DgjmRfDvKmFslRL+FvOE3idvnuTwwPp7Xz1/oAaShAYbbn96HSOKZg/IZWLQfN3WU4Cv79lp+GqcXMhcnoVQDsvT8QCo8pwvuv6Oo1rKQ0Cuvrxeavr+spOps4OSixtY8CO6PFYwIVy0Pw2xlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRbggECSETwmrtEE14K7JVsAUtnyg2BNoE5q5PfLJjo=;
 b=BQUfyNWq43PMd3dTBKSpFwxAFB3FB54PTKC4F9shpo0/3uQ7cDu+quPF9XahQzHg1D92mojOlIPYvBEiiN+nf3llRdZl1HOeTCFEimSrVay5o5/KWNQ79H3XeCAxyGUhBKMnqfoUC8T9qyj88G+Pvzsquwso5LIVvRUa2HiJoBtfMjb+tsLRhW68huDQt8TBKCZSFimo7D5Rpc+HVECn552A3PDUqnLLX9RRHBD1KEC9siINKoTSIb42ys7UQoKE/2mVPVyaXQ8RLb4dLiF/Lzl6fWu4mfY4FluHSSEfL1uDCB7DXDhzmyHXhs5GEx9nYbfJeZw7dKJApHavhYhxQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRbggECSETwmrtEE14K7JVsAUtnyg2BNoE5q5PfLJjo=;
 b=I/7vVqUVpu3ruOeq0UaxNoXnSN0QWKJZUH0nh2HnS2UtCFXwyvS+eu964ANScsTayEMhwkBbvZzP82vLdBZEIJUhvADiEszttsY1qIVgtdQwoBcgSKEt4WqcfjjoeHOUKuo7lX/OB3rn+BWajd+La75Rn8CE066S2+X5mV9bhFU=
Received: from DB8P190MB0634.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:12d::21)
 by DB9P190MB1051.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Wed, 16 Dec
 2020 10:44:00 +0000
Received: from DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
 ([fe80::fc76:b821:1966:db40]) by DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
 ([fe80::fc76:b821:1966:db40%8]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 10:44:00 +0000
From:   Sven Schuchmann <schuchmann@schleissheimer.de>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: assignment of spi to can channels
Thread-Topic: assignment of spi to can channels
Thread-Index: AdbTmBm1lZbEHNKQRxyl9xCamZQMEQ==
Date:   Wed, 16 Dec 2020 10:43:59 +0000
Message-ID: <DB8P190MB06343276BF64CB3530DEB5D6D9C50@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=schleissheimer.de;
x-originating-ip: [62.153.209.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c87ffc03-477d-497d-537a-08d8a1af7f62
x-ms-traffictypediagnostic: DB9P190MB1051:
x-microsoft-antispam-prvs: <DB9P190MB1051234E01647DF7EDC4DBEDD9C50@DB9P190MB1051.EURP190.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZFsxzD/7IbaCIBV0lUPM2q+Vb44KvhlQbCHWvQJEHDyTW7gPOnJRMRGc1Wuplp/IxhMMbpn1QjVf5b5a2S93MlwpdQ0lzXwm8YLK+K4XWLostqiOglbw91ntkPRr85YcD+3T6Y9e8HFCbiiQdf+VOgPDY/jZtT73uV12Y8I3j6c7F6A3Vl8dosVZgCyofPLQddfRZuavqo1uXuwHXrkRUHwUM4FdBg/oox+W9GiXMPdNVfqCKRmLiGHSPyO7bsl6taG1BYD6aHImQVxij34SKb/N0Zlm4VAO8eZDWbnSqGToDidQyAPv4zQTjGtW8a3bFw6CzGFtJSx7e3GllArN1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P190MB0634.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39830400003)(346002)(376002)(396003)(136003)(186003)(8936002)(55016002)(26005)(7696005)(71200400001)(5660300002)(52536014)(8676002)(9686003)(316002)(66446008)(6916009)(6506007)(64756008)(66476007)(76116006)(478600001)(33656002)(4744005)(86362001)(66946007)(2906002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IRCv7XrXkgIdnp3xR2pZUXyTkvtTPb550Dz2CBqnfkkrxjAKxns4yU0JhE93?=
 =?us-ascii?Q?K5PAnhHdHrbStLzOscKdPjkA8cCTSbA60og0FPgqTnYbGtQAWsKLKljbPRvn?=
 =?us-ascii?Q?TRCgcDBiayqplNLyyzlvKUym81L11YlEEqo+7t2sqdvv2SmjfNx03YBhqwmj?=
 =?us-ascii?Q?XMubJOwa0yfgXX+FGUWNsVqjmHT3hvsAe8v7jTMIMA02qNRHzL1QWZwA5L4L?=
 =?us-ascii?Q?cMAQslUhn77bHPB54Lj8WQp8vdPRCkyPlEFoFO+v8+w7Mu/jLy4CBWpzLDgT?=
 =?us-ascii?Q?Io3AHtfwY6PPyIi+fkmBiB0C7RdI2gi+vDvtZ32crwpTkp8rd9KWUJlLHOv/?=
 =?us-ascii?Q?tN/UGV9sZTbaHUDCicw3XyVjnqkaSpTMMIFGzM0rfZTO9lgX6kNksgnSFpk4?=
 =?us-ascii?Q?T2lIZzqzrFULAOVy9Pglv3xhIEspHy+i+dO77KGfMZ0jLNdd5YK/9eluGEI2?=
 =?us-ascii?Q?HTZLvUoI3E723mVzPr4VSP44FcbePmEk7hFh2ecH4qIT630CldGra5CZYfAW?=
 =?us-ascii?Q?mZFimXzdOlkVsjqo7+OircylTkQmyNfsa9wohelTPe/J3ZXB4/Re2pLPOYFW?=
 =?us-ascii?Q?ISm2+ZVCn2y3XuOe1DNJRBxOz0kxM4mlqrCQ6hO5tZMqbezNOXvvL+zKDqMw?=
 =?us-ascii?Q?UijFoJbfO9mHIxjIv9tTcWI9Pwvl1eMvvIcNlGLno7ehQl/x+ThOgXFlpu7U?=
 =?us-ascii?Q?AkS8oUbSSqZvGw1dRh7KTMUMLuid3yas01ODQpcdzl1OdmG4SaovjGQ57aTH?=
 =?us-ascii?Q?ecwNRwfNBedhT08CfiqVRx1FR+pOp0+mPcxkkklFpu9zcsM8vthARHM+VAq9?=
 =?us-ascii?Q?6XfLBN+eA2C14Z4GrKxoNCOVQYsAZiYOUKPMGomv644gIBqCaG1DTyJL0/5s?=
 =?us-ascii?Q?eh5WKDe59UM0DIhsKXmxAA2PoiU8oj1YoxQyW/HF2p9gKo3Oy/82jdjh6O+U?=
 =?us-ascii?Q?iCxGmCqvM3NAqsu9/3ci4kZfD+6x8I0h7XCA0M8qYi4=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c87ffc03-477d-497d-537a-08d8a1af7f62
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 10:44:00.0199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Td1FJ3Ul9bCq9uj/WYa2SIAxu4xYsjCMs4TsPX2voe0uwDpg018gIYfUHcUYhITs7JXfCnBja239F19N9VzOXSCpeIsYYp9HZHDxqdAa4fM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1051
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,
I have a question regarding the assignment of spi to can channels.
At this time I see sometimes this:

[    6.665217] mcp251xfd spi0.0 can0: MCP2518FD rev0.0 (-RX_INT ...
[    6.675670] mcp251xfd spi1.0 can1: MCP2518FD rev0.0 (-RX_INT ...

and sometimes this:

[    6.612654] mcp251xfd spi1.0 can0: MCP2518FD rev0.0 (-RX_INT ...
[    6.623504] mcp251xfd spi0.0 can1: MCP2518FD rev0.0 (-RX_INT ...

Probably asked a thousand times but I did not find
a solution: How can I fix the assignment from spi0.0 to can0
and spi1.0 to can1?

   Sven



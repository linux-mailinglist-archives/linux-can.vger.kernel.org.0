Return-Path: <linux-can+bounces-388-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDC587BB34
	for <lists+linux-can@lfdr.de>; Thu, 14 Mar 2024 11:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D07A41C20BA9
	for <lists+linux-can@lfdr.de>; Thu, 14 Mar 2024 10:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE4F6CDC1;
	Thu, 14 Mar 2024 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="IT9CEqat"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2135.outbound.protection.outlook.com [40.107.22.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF6D5D463
	for <linux-can@vger.kernel.org>; Thu, 14 Mar 2024 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411925; cv=fail; b=KgoEWBWxpVqHV5ryyB3gi/Fcy0rR4qL8K6RRof8dh5eUqLyrASZxF0c3F1ZFIOlRXR+hWJ8qBbNa7Fkp6HR0kE3mGTbQD8w7TdVHkhHr5EtGZKXozLhPsA240a06mbPeGXHzF0edV5I7UbL1RoES0ez8MTdND7jlLQBvru5V73Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411925; c=relaxed/simple;
	bh=p/7teSUvFpLMGubDONhAOLy6LeqhdFKbSBElRPudtSw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Q2qILbz/h0pYRIyWOrnPeMSFu6GyyM7mHJPTr7vquimsWZ7OBaf1wpuPstNSnQlrfzTAosTL3azknObmlgrqeCvGWIbMK+taoRBdY0rVj8fpJ03YFLfJ/9VKLEN4mOcvkHu5FWIq9UhW1tIXjUB2Bb0MFRNgRD7gdDDEKwcBEGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=IT9CEqat; arc=fail smtp.client-ip=40.107.22.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bf0AP/axm3W0iurMLZ1zxhSxojnC+oBx1b3YusICh3Xx4IssCdbsTWp+maiQJ7a3FTzyqitJQHiYmHbFW4Lph3Ej9NBofh35d8OKtg0tTx6rwRRj1gOGQvk7sMKlaKtLQCq2wsJcsUL2XJrzqVe6z5HZjsoBcGkKTvpF4jlo7exHlrKY6XkQlS05m859rNM42K8tgs89st+AbWbA7aat2T1vI42SmT2dFGuPgPJHn0MYuEpOg19Fk7nPaQOkfVhHObYHs7NFc/YG16T4IBknaiktfaiDaklJr7/qLNu0SptJpgcE/Hsn9ClLtM7ann7akeuU9C+EshWG/qRy1/niGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/7teSUvFpLMGubDONhAOLy6LeqhdFKbSBElRPudtSw=;
 b=VNKJOrRAIjalb+MPW7/AQGz00vaYscHCy56D9u14Q503lBkfA5T5W5dFd4N6odi//ohzMftB6Gvts0lwz74DDnvxKVOSL10uuH72b8oIbOkQxbvA0fOteZKg1CGCEFVY5wuGdj92YOBgXxv639oBrqztpDt1A+3G8WlxlNnqXucDvC7jGj4IVGL2npurxtkF2OczPcVorH/mcatkJ1WKthfhSTIUeldWDVnNpPwVWGq+gDyIbudiEDteE2GFU5KjYCtQoH7ccysqqLL7i0irBPCe6sdED3kOMo3upJRsH1O73pL5Hc8Ly/c+OpAyYlxNyauFXcHMa4BAlqBhIu03hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/7teSUvFpLMGubDONhAOLy6LeqhdFKbSBElRPudtSw=;
 b=IT9CEqatinBgbS5W7SeJTgThZk5LoIKOIVM/sL9iGtalzQB+d6vAX2lQENYzy90EVnKWaUA3InlOwfIQaoPCM0katUte+27SDFKGRq9oRFrLC96osHaK0BegTGNrMFI/56WCQHcTsueWaLGDFRHwcTKuoWfWRGHhRNc9mjwV65Q=
Received: from VI1P193MB0559.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:144::17)
 by PAXP193MB2217.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:22c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 10:25:14 +0000
Received: from VI1P193MB0559.EURP193.PROD.OUTLOOK.COM
 ([fe80::2c3f:a538:fce3:55cf]) by VI1P193MB0559.EURP193.PROD.OUTLOOK.COM
 ([fe80::2c3f:a538:fce3:55cf%4]) with mapi id 15.20.7386.020; Thu, 14 Mar 2024
 10:25:14 +0000
From: =?utf-8?B?TWFydGluIEpvY2nEhw==?= <martin.jocic@kvaser.com>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"mkl@pengutronix.de" <mkl@pengutronix.de>, "mailhol.vincent@wanadoo.fr"
	<mailhol.vincent@wanadoo.fr>
CC: Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH] can: kvaser_pciefd: Add additional Xilinx interrupts
Thread-Topic: [PATCH] can: kvaser_pciefd: Add additional Xilinx interrupts
Thread-Index: AQHadfnn/OdQWoVGAkGj1Ih8PK6Qnw==
Date: Thu, 14 Mar 2024 10:25:14 +0000
Message-ID: <2ab3c0585c3baba272ede0487182a423a420134b.camel@kvaser.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1P193MB0559:EE_|PAXP193MB2217:EE_
x-ms-office365-filtering-correlation-id: 4500a505-58d6-410e-ab58-08dc44110995
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JCvocVqNRJEPpaxsnTSCTZVnogt8GBpOJ+ztOOVcCviwpFxQZmtuTKgXsCf0DdTVj9ogvATYuHpGC2FAoJKPXcy1ncucplbss5ezTe/nvqkZPb1b2lXxVdeZcFRRtvFZd/Fg6Fr6nua+Ra7dpbZrOVktzTXd2GHy/jt2r9B/JBXd8+MQgxCP7jTvzZg+INwJIyn3b9TkmJTaAs1/zQ0XQnp/142Btfistmr+FAGF1rsnyGFYD9JEThqdgUHTt/d1YOxI6gIZvpZo0MaSWLlDqdJpWSJJ511Mep14Tm5KDhP2+usYhSlhtfV0CcyI2RNCulrBXmstEAS8vky4mHUcBGtL2jDlL1NAPrJ+oJM38ThsuBiYn2exVZ0pqiezEmYQvRcfD5J6jm3NVGUaYgT6Hnw9HTAGGz9LgZHMBA7vLNfyUYLnQ9dLHqa0yiQJ9Ldy8x5D3eseI2iqqfgBuj6yk3EpWsHa/nSewbKUBpo80quyq5MoQ9cdSa7h58udOpkU3VFU/Qq4rAtZKrrkEhGNv2C0EWIGwmoZyt/mlCz9ZZ0MJiHw8i5nes7hFGyyFbgQ0cGRqVd/bLV4AtzXykFpKIDAXEeVRoDDuZ1E1ItgUnLp7mzNUlSnNmj4MOM/oFxvJlHe3eET4tJZggDmVmt9MvcUGZ/zktlf6/OEnnORQxI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0559.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L3FmYmtOVFJ6YmkxSld2TXd3MDl6TkZYYVVFa0hjVzRRckw0alg0UFZhaTUv?=
 =?utf-8?B?QkNqTkIvRlRTeEY0RWhta0QvMmVoTW1wRk10YjVGNlhtMVgzRWRocTk1Y1Iy?=
 =?utf-8?B?YjFTOU5EZmJMcGtSK2tHUWxGalpsUVgxcEgzSm43QjJMMWJiMmRFRUxkdlU2?=
 =?utf-8?B?UnNrekVoZVRzUjR4RDE0dlBNR2Y1S1V1Z09KeG9QS2tqZDByKy93Y0JqZTVF?=
 =?utf-8?B?Mm5iSlZnS0orYzJDWTYzVkJJUlUxYnJDL21RZDM1eDV6UGp3OUNKeGxGNHZ5?=
 =?utf-8?B?bVRWSm9ibU53MUl0Ry9yUXFjbFk4d0M4aE82RTFMc0FWdGRQVW9vbk40UWQ2?=
 =?utf-8?B?TFJ3b3hRODVNVjlKOVU1R004ZlVROCt1Q0ZIbmE3dE9mU0hhRHkyT2hZc2Zq?=
 =?utf-8?B?ZXlZWmFKeXZKelBySmdydHNEczBRZmptQjg3YzAzSHlXcXQwdnBEblREMVJr?=
 =?utf-8?B?WEt6WTBGTXBkSXVhZ3JvS3ZXTnhMYXlqUGhrRjVtT2ZzY1pkUjgxUDdZMVow?=
 =?utf-8?B?Tk5qZCt6SVNYUllKZVZheGQxbTRRempEbXZiMFEzVW05TFhaOCtYdVV2OHNM?=
 =?utf-8?B?Ym9ZSnkyOUFjdVpjR0Myb1NGVlUxUWZZMDVmQXVjaW8zdHJJZnVib3l0aU04?=
 =?utf-8?B?bGx4TXg1YlV5ZVVxcjViNVJiVm96RW56K0VrckNGR0dZSlArYi9ZZHdtNUds?=
 =?utf-8?B?WDBZbUdHVXJ4MFFlWDRTemlrTklpTTJRNnR1dDdwNHg2RFRoTTVZbzZ6Sk9v?=
 =?utf-8?B?Z3IzRGlYcGRqeGxhTWZMMmltVVh6bDE4TytSbkJ6MjBMb0JielJzcjB3RTBn?=
 =?utf-8?B?VlNzVEV2YmZSZ2F2ckZUb1JkY3pkckUyei94QzBrRUN4SVJBMmVaZnEwYmla?=
 =?utf-8?B?MzFsYzZBNnNQZDhuNVlwT3d1emhjdDVPd1lCOVpwc0FtZUZUYno3SVczWnhO?=
 =?utf-8?B?cUFnUFVWVGs4U3lKcUd4a2ZjUURqcGd5dE9mK1lLdUVvNUErL3c2eDJIK2gy?=
 =?utf-8?B?czRvNnhJcGFFenFWcGdmZGx2cmplL0tGc3o0eDRTSU1oVUhMMWh2cGNnT0c3?=
 =?utf-8?B?anBNcit6OGtyY00vWFUwSzBHclFQb0ROWXMzdDlWTnE5RHd1RVBUejRVQUU0?=
 =?utf-8?B?eVFKZ0hzMEZNSXZyeDI0Um80OG80ZldOV2lOZXlMelZ1ME0zSHJrMDlmVlVp?=
 =?utf-8?B?dWFZRDdsdzI4Ui83bjE3UGJ6ZmE0TmswNy8zbFdORWRUS0hFYTRuc3ltTFpC?=
 =?utf-8?B?a3RZUU4wVUREMmdGdGtGNFJRNFd3enJUNHhQYTdMU0NBNWlMVVpjcXJzd0tW?=
 =?utf-8?B?S0hTZ0Y2QVFqYzhlUEdnUkNCYytRQkhHSWFsMkZwMlliLzB0TXRwUUxjQWV1?=
 =?utf-8?B?aHVMcUJuUCtkekVOaFE3cm9Qei9DSTU5WG92S3dlNzJjams2akQwMDkrc0F1?=
 =?utf-8?B?T0ZidGlFVDBjWmFTK3hYMFRuRUJsVUE3dllqSzlXQUZHZ1RLOTFTVHVHYnhV?=
 =?utf-8?B?c1dhRDM3MFRDMDVHN3NMbzA0RldNU20wd214R0R6SXoxOXFrUnZ6OGVRV21U?=
 =?utf-8?B?QXdNYlgwLzE3K0JtenRTTmF4NE96YisyaDlMck1zWGxqRHEvU1YrSXVpQ2xN?=
 =?utf-8?B?eGM5Y1d2VktrTDZCSHdwMnQvRkVSenVSM01kckJUSjk3amxJeTR5VUhVRVRk?=
 =?utf-8?B?dU9Nd3JqTlI5TmtNeGJNUmtxSXlRYXNpSzBZRXlMMFE1aUdvSDU0YUVXT3Zq?=
 =?utf-8?B?MTd3R3A4WnB3WnRVQitENzRtbW9CZUdKYmcxayt4MVdmNlNhV2VyV0dKY09t?=
 =?utf-8?B?WFFoVUM5VWJmbDBlajZ2N0pZVXpYRDlLV3UycXo2TzNFdkdLeDVhdzN1dERz?=
 =?utf-8?B?WlBseDVrMC9kL1l2bW54NDNUVFQzSEZXRGRCeWk2aWVNbW9DKzdvUDZVanRv?=
 =?utf-8?B?WmFKU1FYaUJLOWc2MlQ3Q3N5SUtrK0JGL0JFQnYwcTV1c0w5YUg5L2g1S0po?=
 =?utf-8?B?SEZoZnlyYVo5L0NyN1FGcTczTHN5WnJnU1M1UjdmV3VGbnZ1aXdBTXlwTmsx?=
 =?utf-8?B?ZVZ6SGVXOXRzMnZXNWZ3ZHVSZjNYdGJYemNtbTRmK1pOdFFnOG10WEptczdk?=
 =?utf-8?Q?wS72m7zH+Iz8N5LX5y0MEs/Mg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FA0442113E3FE4398D144ABCD0DBBD4@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0559.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4500a505-58d6-410e-ab58-08dc44110995
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 10:25:14.5255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rQoyttM5hcFTVygU4fxV6JwOS/N0Kgy/YArMc7xWt4JpA5NSIBvzENUrvS1eBKBdw6e/PWvCMg7nk+lMAMGiKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB2217

U2luY2UgWGlsaW54LWJhc2VkIGFkYXB0ZXJzIG5vdyBzdXBwb3J0IHVwIHRvIGVpZ2h0IENBTiBj
aGFubmVscywgdGhlIFRYDQppbnRlcnJ1cHQgbWFzayBhcnJheSBtdXN0IGhhdmUgZWlnaHQgZWxl
bWVudHMuDQoNCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWNhbi8yYjJjNzIw
YTc4OGUxOTA0MjgzZTM1NGFiYjMyMGFkYjViNjMxZDI2LmNhbWVsQGt2YXNlci5jb20vDQoNClNp
Z25lZC1vZmYtYnk6IE1hcnRpbiBKb2NpYyA8bWFydGluLmpvY2ljQGt2YXNlci5jb20+DQotLS0N
CiBkcml2ZXJzL25ldC9jYW4va3Zhc2VyX3BjaWVmZC5jIHwgNCArKy0tDQogMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L2Nhbi9rdmFzZXJfcGNpZWZkLmMgYi9kcml2ZXJzL25ldC9jYW4va3Zhc2VyX3BjaWVm
ZC5jDQppbmRleCA0MTZmMTA0ODBiNDAuLjJkNTJkN2FjOWY5MSAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvbmV0L2Nhbi9rdmFzZXJfcGNpZWZkLmMNCisrKyBiL2RyaXZlcnMvbmV0L2Nhbi9rdmFzZXJf
cGNpZWZkLmMNCkBAIC0zNjksOCArMzY5LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBrdmFzZXJf
cGNpZWZkX2lycV9tYXNrIGt2YXNlcl9wY2llZmRfc2YyX2lycV9tYXNrID0gew0KIA0KIHN0YXRp
YyBjb25zdCBzdHJ1Y3Qga3Zhc2VyX3BjaWVmZF9pcnFfbWFzayBrdmFzZXJfcGNpZWZkX3hpbGlu
eF9pcnFfbWFzayA9IHsNCiAJLmtjYW5fcngwID0gQklUKDQpLA0KLQkua2Nhbl90eCA9IHsgQklU
KDE2KSwgQklUKDE3KSwgQklUKDE4KSwgQklUKDE5KSB9LA0KLQkuYWxsID0gR0VOTUFTSygxOSwg
MTYpIHwgQklUKDQpLA0KKwkua2Nhbl90eCA9IHsgQklUKDE2KSwgQklUKDE3KSwgQklUKDE4KSwg
QklUKDE5KSwgQklUKDIwKSwgQklUKDIxKSwgQklUKDIyKSwgQklUKDIzKSB9LA0KKwkuYWxsID0g
R0VOTUFTSygyMywgMTYpIHwgQklUKDQpLA0KIH07DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCBr
dmFzZXJfcGNpZWZkX2Rldl9vcHMga3Zhc2VyX3BjaWVmZF9hbHRlcmFfZGV2X29wcyA9IHsNCi0t
IA0KMi40MC4xDQoNCg==


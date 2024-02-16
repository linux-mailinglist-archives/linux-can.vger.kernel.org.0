Return-Path: <linux-can+bounces-295-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9C2858166
	for <lists+linux-can@lfdr.de>; Fri, 16 Feb 2024 16:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45AD12827ED
	for <lists+linux-can@lfdr.de>; Fri, 16 Feb 2024 15:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4544812FB24;
	Fri, 16 Feb 2024 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b="LiK1h698"
X-Original-To: linux-can@vger.kernel.org
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2094.outbound.protection.outlook.com [40.107.135.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1410612F596
	for <linux-can@vger.kernel.org>; Fri, 16 Feb 2024 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.135.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097616; cv=fail; b=BSODzweQzGNtPBoRuXoYzc+AvnhHqTtNTFd0Kovo4dP9tmSuLqlKjGdHdkh9eN3tXVFRr2oBT45TPWUjhtlcwknSX9n4lQxRec5OcDPOmgyyO3a2rQM9ktMnrYK9zvDQncwGPAJ5CiQSHdFfDYMXQ+7UYmt5Nj+5Yyga/PXSzws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097616; c=relaxed/simple;
	bh=SFjUKB5b7WMcUSxDL5yImilYz4LG9cR7t+BHDnLBnys=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RUb8X5Psxm4aZ8770fSP2aZpsM4O3mfsnjblkYjq5Zradg11hXV1SzMYMrOtwC5FjFXPVhOvf+Sh6tBkS4TclDGsdQ54wyUrrD9MJEkw9UDG/S8jwI1t0I/Zyd/d08GVnmgSoshsc1PtVws4T1cUjKBa//iLpkowGkol+hY1l4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=LiK1h698; arc=fail smtp.client-ip=40.107.135.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schleissheimer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schleissheimer.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpMChzCfA1a5o4uVeo9AeeETwUbG/54u3J2agMkpzNHt+m1g/HpgIxs5h/TOGEG7FkEaRNf9BVYvwIeroHwWtokbntWiQZKDR++tLAn5cTlrZgDVBA2lhRdcN01CpYTYZq0n0pAGjK3Y9t5uhOpGrIkgZuyDxffTw1rtGQ6LvLm4zYGnBEyhfRshoYO+LlSEsJpMkzFYn9O5jvODevllqID/8C8rv9r9X1Mrut1rbvSq6kloEsRAJ4pSeAEqFrF8uCl5gilq5mkqoFBhx7DueScZHhTOCApkHxHCcs7Ots6gpJg8Ixf8nfmUtHRhX7ptNQB0y3ESrj2rZIdT5CdpjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFjUKB5b7WMcUSxDL5yImilYz4LG9cR7t+BHDnLBnys=;
 b=HOFhedQnky9yv+CvoF6dcyVFdrsZWyWtYPAF9NpZ9x7I+CggNabPBrsQj0wznCl3NV/JbNuQ0RyP+Fu4gnSu3kLm8luMrtlbzU96J6lfWa63iLXVPHkDGdsfIMmaOmCZUI8o+Y9mwf+YXyxH9d4KsKBz1s7N9irW7Oz1lt0RMMC+FFLCHLlivtaDvmgSlXavHWu3sgfgN4oAk2yP7Q0UPFnSAmJZVSOSQUzGjx04DMb+LusexiDgi0jV8SNi/PSf4rppd+7taQH6TnUwDnthlVRJWh35rH0tp3UdoNrsx3GNdp+1qqdlo5eGwjJJ0L0rDdtJZ7c3b2pKOoaHrU4a1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFjUKB5b7WMcUSxDL5yImilYz4LG9cR7t+BHDnLBnys=;
 b=LiK1h698qlc+hGjrkcBA0NG544w2+DDQWgaOQN77cU2ESKYZd7i+qTrHAVCvuM8J6xQwLqHFHBvnWtXVd6mrGhbnKxRLEE9g6UN5jIiosc10FfmsLRt2iAcvWsgEleQSxniIk3d/8tAa285IJk87r0vYmYEA+MOvSiL/l6f9Mpk=
Received: from FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6d::6) by
 FR2P281MB1817.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:3c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.31; Fri, 16 Feb 2024 15:33:30 +0000
Received: from FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM
 ([fe80::851a:7bb8:aeeb:4c2f]) by FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM
 ([fe80::851a:7bb8:aeeb:4c2f%5]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 15:33:30 +0000
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can Mailing List
	<linux-can@vger.kernel.org>
Subject: AW: [PATCH 1/3] can: peak_usb: fix potential "UBSAN:
 shitf-out-of-bounds" issue
Thread-Topic: [PATCH 1/3] can: peak_usb: fix potential "UBSAN:
 shitf-out-of-bounds" issue
Thread-Index: AQHaYCN8uWkfOlmgrUWz+kWHmqhip7ENGVBI
Date: Fri, 16 Feb 2024 15:33:30 +0000
Message-ID:
 <FR3P281MB15528FEC8A3636DB7A694FDAD94C2@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
References: <20240215152656.13883-1-s.grosjean@peak-system.com>
In-Reply-To: <20240215152656.13883-1-s.grosjean@peak-system.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=schleissheimer.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1552:EE_|FR2P281MB1817:EE_
x-ms-office365-filtering-correlation-id: 3592181e-b8e6-4e98-1565-08dc2f04a0bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mw6Gve8AlWOJ2m5oWzb1NsAUNquJjFTbsGW9Jt+Qkf4zuzflORcOBHxVnMRp5bFieFp8ThmxwGs+wcppOmyZZmuRKlxcOKQaacoVq4RHMKBjDFhzd8Mq13jHpBMw6Q86DxQjhDePT4rYNgZPVD266jFQMs76z5l3z68saEyTv/gfrs4hVzkG0xm/gGZqn+FyN8htq3rVLXzN7qe9lPbUFkBYB/7EIf8CjPyS1Q7R8pwf1fNweYNrG/+gyIsv75+LRvzxHXWRjxZzPVWfvKbwjoxIsYzR1EmfpKTMG6/+ZyFxbx+2v/q6zkE+WmRZyWxBJcEbAiWFsB3jpDIp7BnUJ4nu1q1jUi1P2BfL1NrcuzM1ToQql2rDSVUdBXnuptk0u44duPrsgLlsDey7qQKmPmmxU143oOIUT4r58bR3PploA7vn4x6p1E4KewRJ/NTee/8FahzTWCM0Rsa8Z1G6lQMgPWMKK1ktXDvd7SQJyJyfw+b1BpE7MC6tshE0CLbu+wgJj8w5GVXzDKIjOy/qIZlWLNYR3mA9HHNntyQIozavnKqnFqMMAyfzl/qInNaI+fwKsfWp/yiZQfc+n8RnZa0gKTi2UxQWG9Svt1QIokAH3ieqTY8LefpiKh0Fr5SW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39830400003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66946007)(76116006)(2906002)(55016003)(64756008)(52536014)(5660300002)(66556008)(8936002)(66476007)(8676002)(66446008)(558084003)(7696005)(86362001)(33656002)(38070700009)(316002)(9686003)(122000001)(478600001)(38100700002)(6506007)(71200400001)(110136005)(41300700001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?uMTOJQcWiXVkmZIu6S6Ncox7zc+jAgUlTWkWwyRr8TNnxMS84+wJztTk7H?=
 =?iso-8859-1?Q?+HERloB4wq1JpaeccgxfgitbEUjr8ZJc4Z3Vxd4TwA5f40YBZl7gN4A+7g?=
 =?iso-8859-1?Q?E+42gg3QekERJUC23KJ5/UY6PUcWDEPFUy4tXoNavcP2c3bm12K9tBPcn1?=
 =?iso-8859-1?Q?zGWBtuG3xYr+9EzeLmIYJ5yUL34ihs/R2VArYqaF/AtanAe/bCOgrTseaL?=
 =?iso-8859-1?Q?q8Lxnatjo7olN0Wh/r0A7iF5u+NmAhJzi4TdyL3zORfTW6hcb3HaC1C8jc?=
 =?iso-8859-1?Q?KWdgp5aafsT/gBV+T6wNsEAyPK6z5GLvY2EFvHx94MzQ0ZmEcEGtaMUWX1?=
 =?iso-8859-1?Q?h8YF784QzlhWBg61dpllKPR2mHmqFjOm3h+IsHyoFmUxc4A8asNmkYUap+?=
 =?iso-8859-1?Q?Ydg3JIH7kaOfv9IdVXmWN0M84TvN3SJZ5443ICGsnpHc00yNTk9qkvbOeB?=
 =?iso-8859-1?Q?TZ45djVOG9cQh4ydHH7LaWZbCzR2mlG3i/omxoHrRQFt8tdqs40c4TGt0Z?=
 =?iso-8859-1?Q?VX9lD8KSm2wYyoferuxlOTitEg17pcPJVC54hhQO1nbqaItZ9fDCB5xJWq?=
 =?iso-8859-1?Q?bnVZmXaOk2P+Lu93LG4narn/oKqVJgk7gXB08UAHXNdjuyBf3d3AKMuaSi?=
 =?iso-8859-1?Q?s97X/Zmutabu1QA+D3/Ehy9jEqRVKVsQwwaO7yMtIuk0Yw0+A5vEk3ljoa?=
 =?iso-8859-1?Q?jRB1uhEpIWpNBcr4RXti2XfYd0BDDGkIseFj0haaQjUteaEiRgwsS4k/24?=
 =?iso-8859-1?Q?Kd1ys1O4ujoRr/Jjw2CYbUOWTaV13ma6/6ms26+LN2hDao+gkhrTlqv+Kb?=
 =?iso-8859-1?Q?U2J3ELblHLUEQAKC1rtcdK9lv/QhQIu4zmzycMI1P2nmSN1/NnoxXUPwjk?=
 =?iso-8859-1?Q?V7WVxSL9dMZsLt/FaCcBVA87whCOQdQMfGBAY4yaaQgOmtmNOAolIsbUqo?=
 =?iso-8859-1?Q?hciQ7L188O5SB8g4+A/nH7qPI5Z+As/yW6/woBtEuyjC78/ReqZh4R/lZs?=
 =?iso-8859-1?Q?NG5QWndYhFWbZjgU2bJU37ahw+t/tAu6wzFjkRIqVmI5ZDMoYwCZANislg?=
 =?iso-8859-1?Q?7cD8OnXGNgK18HnuM8b1bdKnIL4/toqvfY8A4QOyequKrHsrhM8xAVR2sZ?=
 =?iso-8859-1?Q?hRc32BBXDfyVIQCm9XwHIwUdqWO6jHxqbmE3CzIEjGXEuYtGY8WQkNNlvz?=
 =?iso-8859-1?Q?Ku9FRKrxX1cPIYwk+kfchbHiaNkDuPEZtZU9r//WfFpQBcrpdzdN6WQP21?=
 =?iso-8859-1?Q?LnQ5ACeWCQ9zkcapDHYd/7iz2kxD5XX+/upNDrEK8UZwtX5gH1T/ChTBTv?=
 =?iso-8859-1?Q?bjvOg0quNZRMpdmmmTthsMbfRjmQrsIWLZDeY+rZ3fydZSi+1ykTQECe0J?=
 =?iso-8859-1?Q?LpQOFjXa21vlXvC+A0WulalMQ+hyLQJK18zajAynS4MjCnjoF9zxCamoTh?=
 =?iso-8859-1?Q?0AnNUl9EwqOJejtNtmqdn0A69zKSulZHBiso0iv7C6p3H+3hTa0Z3c9HQc?=
 =?iso-8859-1?Q?/ZPoMDLCjSuTNhKEDFudZKJEr0o48w1ga0aQBv4sCFPJkeAu3m5td0C9ok?=
 =?iso-8859-1?Q?jiQx1Bzbzcs6mqX1djWwL57Bth2pMsAPMhL6QSm5Hwev93vV++kixtPoPd?=
 =?iso-8859-1?Q?LxEME2c53hj60V2twxz2/1i7AdBPEfTW8bP4xIONdBXiHYn3sUe6Q36w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3592181e-b8e6-4e98-1565-08dc2f04a0bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 15:33:30.2480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9L6/FwpsCzz1aZ5aJ4klGAuz99ZtV57ZHxFOwBA2XnpqA2vFmZdD65qd7jcuOir+UbdZjsRmzNVZi2GxRcZTOfgoJ2hobcl0YO4lWKVrfmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1817

Von:=A0Stephane Grosjean <s.grosjean@peak-system.com>=0A=
Gesendet:=A0Donnerstag, 15. Februar 2024 16:26=0A=
An:=A0linux-can Mailing List <linux-can@vger.kernel.org>=0A=
Cc:=A0Stephane Grosjean <s.grosjean@peak-system.com>=0A=
Betreff:=A0[PATCH 1/3] can: peak_usb: fix potential "UBSAN: shitf-out-of-bo=
unds" issue=0A=
=A0=0A=
Probably the subject should be "shift" not "shitf"...=0A=
=0A=
Regards Sven=


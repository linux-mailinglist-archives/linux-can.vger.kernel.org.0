Return-Path: <linux-can+bounces-7629-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Cy/IW06Bmo3ggIAu9opvQ
	(envelope-from <linux-can+bounces-7629-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 23:11:09 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F02D9546F1C
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 23:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC264300E639
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 21:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17633F413B;
	Thu, 14 May 2026 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="IWXHT238"
X-Original-To: linux-can@vger.kernel.org
Received: from mx-relay07-hz12-if1.hornetsecurity.com (mx-relay07-hz12-if1.hornetsecurity.com [94.100.139.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049F03CB2C7
	for <linux-can@vger.kernel.org>; Thu, 14 May 2026 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.139.207
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778793066; cv=fail; b=XeRjkdsSsjz4Zo3nuBog5STcE/XOZOvWA6QJz9HWkNHb9GZPajW/RdVU0O7+58jZaOEOgNClPnUtdanMnPjWeDMgBQkL/XqLU4gjtUD47SuPkDmEsqRAWwx0RlERuy9jKr3F8zgD+7DozubnpccHQQQ9meR1juzSjS6UnFs7+oQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778793066; c=relaxed/simple;
	bh=lOp8oSDWjmPL5U4XYDbU2Kdy1lc8A4yCQU6DFVkNn9Q=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=i7Ih1TF33OhwZf727IHkZYwuLh7KNAjmTw6ori2CpOwL6Lj//ceHvGXTSrgRGFJs73bpzukADXWeV7bL5NZyPkcStn9S5Iqmu2Lhnry1AtiiQ5O05wfXIrtRdp4Szi0buGh+3sHHcJZfbi28KDBgxoKo7Dx026T/WyLOzvc92V4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=IWXHT238; arc=fail smtp.client-ip=94.100.139.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Authentication-Results: i=2; mx-gate07-hz12.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=52.101.72.121, headerfrom=witekio.com)
 smtp.mailfrom=witekio.com
 smtp.helo=am0pr02cu008.outbound.protection.outlook.com; dkim=pass
 header.d=witekio.com header.s=selector1 header.a=rsa-sha256; dmarc=pass
 header.from=witekio.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=MeTtBAJYSEySowDshDhg2usVtJSow9loCy3KINWNqUs=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1778793029;
 b=ABEV7WczFEiF5l5svOQ42FtrB1iYbcugZZJ/jMsH3xLgr+buugwmgy1wAgjjPpMeRIprX6dJ
 r20OAvBG/6ZkRG3X0Wn2Ws/0OIJWYKN36dvNLEXol2IWMIruvcn60i8ENUPZ5uYg5TCfHsbPOQg
 m+MMI7VZDqMCJ6nLdYUlKK6FJ5D94xm2EaVxNPcp/Z6dwso/Kj03VVDiPR+GFM/iRxhH/aIW8rz
 PqMSya113hzhIsQ+6I//oy0Vhr/YYCPgebF6iMsFNNoICFY04chOhIQ8WsU77/c9QlAAEVMaxJe
 oMGF7uNRP2bDEwE+zluJANp8kApyB+BxNMx1KCxqcBaUQ==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1778793029;
 b=qawZW02LNSeQlEIbAWbS936fRdyUcodHN27/fFeRnLjxX4bXHePM1rLYbxFqgoqmQaW0Dhvf
 Lros4GE2XB+5NOpzbe/8hKJoqco5dD25t16o4qw6lJiJt2a+kbSjzuNFUJvphzIgJAoRzMARymI
 t+KY1lor/oEyyqhv+VHc3Vg1yegurrfuG74X2b6n5e/J1hFpS9CwqXVjvJZGTJJh/i2kn19J6Y1
 sJW5S0sgv+KcddTI89c1gxTtiECJfDJlw993CXGJF4VTKI3WuCpUo4QfNthFXAqLsjCxzYbS8ag
 nwyJTEy9FXT1oxtIuxvdpOA8LUIHW6bQCIrC4g/RgIULA==
Received: from mail-westeuropeazon11023121.outbound.protection.outlook.com ([52.101.72.121]) by mx-gate07-hz12;
 Thu, 14 May 2026 23:10:29 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLMPk6RHMW6P+gtqnXucZ4XrVM7214mhX6t2q849sQ4FAXuR6u2KRWHX29fpkjoyMddNPblyToJx+u7LfShUECnrt0rSP+Q2Xe0rjBGRpQb3tp7mQ4YsvErU1PTmyg6B41XR0GZsqnUAMcqsM2u0+fBNal630/GypLFeTdWoT2EygwHd7qZm7sXd+MQaingn+S3zS9ycg2xkLmyqRPx0yk3RzE1GQeZKx9UaqkCU7PQVt0HwKNJSO0cmnnYb++MmR8CS5iL2ORbyISfjVFX0SytcaLQPeT2z5sWClvLake0Js6RZTXjE8HnwCUGzb6X2u6ZSCnZ8nufpd0L7cDe4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeTtBAJYSEySowDshDhg2usVtJSow9loCy3KINWNqUs=;
 b=Y61eOQRIw/Cg6LB5JAozitCHV/AShxglezzcOJSHjdvlkuqK8sYlhuKC7UfbVsTeaUya+K7xCAuuiN72gxLiWdsdGsUaACn1acABU/lgPNkIlWi437JanPCRucPw6X5wR9LCKjR5ZCiJIntecbklMbCCqE7KXp+cY0PNsTmjJ4/S2o44JyrBDYnvxiB+ScN/1MpQwFYH+ALSHitvJd1sJ6mHUxjtFMdOa+xloQ49TWSZJM19LCYs6CwG1sWrhGcHj4j5fO1SKX1j+t3bvHOLzWjopAQ4gsZb4ZXDbyD9VGY12lMGpu7EMPa8lUiDuC2UJsBOisk9aial0TUzWpYzAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeTtBAJYSEySowDshDhg2usVtJSow9loCy3KINWNqUs=;
 b=IWXHT238Cwwb0/MyC23SQc9k8f0oKFfYYUaPtIYuxgrnhuyKguF1sMuA24NbOw/RfSSzpBK5X4FGoc383cghRebhzUklPF+CntBeQKYc/Fulx3AGP2Us8tBK20Mo/H1gmjcgQcDRr7ApGIMzNO1C8Uda9oDpP8yYlqIxT+mfB1o+p906yz5Zc3uYyomDbpQqaDrV2Ra2CwmTZDtFMEAfMpY4sAnzHVUjhoYjRBSAbLasyWEnGe9u1AISNEquiyES+38cne16JJxCwyfKZom7JNe/x67NESI8/7CpnwUMnFmO+HymGfoEU+Ny+oE8AJQVHIVgNYoN+0cAQtjViB8UGQ==
Received: from AM7P192MB0721.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:171::17)
 by DU0P192MB1975.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:40d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 21:10:21 +0000
Received: from AM7P192MB0721.EURP192.PROD.OUTLOOK.COM
 ([fe80::b0ff:c6f6:5761:f666]) by AM7P192MB0721.EURP192.PROD.OUTLOOK.COM
 ([fe80::b0ff:c6f6:5761:f666%5]) with mapi id 15.20.9891.008; Thu, 14 May 2026
 21:10:21 +0000
From: Thomas NIZAN <tnizan@witekio.com>
To: "rcsekar@samsung.com" <rcsekar@samsung.com>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: m_can: bus-off recovery issue
Thread-Topic: m_can: bus-off recovery issue
Thread-Index: AQHc4+MgLB8hqxEDH0Gd72gPfOqBKA==
Date: Thu, 14 May 2026 21:10:21 +0000
Message-ID:
 <AM7P192MB0721CEAC90D73E5FE70EC5EED1072@AM7P192MB0721.EURP192.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P192MB0721:EE_|DU0P192MB1975:EE_
x-ms-office365-filtering-correlation-id: 26aa26ac-395a-4064-e53e-08deb1fd358f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|6049299003|366016|376014|1800799024|18002099003|8096899003|4053099003|38070700021|56012099003;
x-microsoft-antispam-message-info:
 RFcIT6bNwBhtIobTRb5QT/5pp3F4l0dYEP1294RlM3HhHMna1f76sjh8fiEcSJUqqHFIPv+yJKX9CBpQJFSGqQqd2YONMh5ktI2nYv0xR4Xkrysoyn164ZTourBuXO4oM2cd8wtWKAqaI8Cf+A9vfyJoaLpWP0LBi+Wd1PkwyP3tAnWthEVTBM2jUitcK7lpdqxCGmyAY+omLULz7jX4y1zUl0ajr/BmSFzBzsJDK0bAYMiRtgfCkU5oml3RjtKFBK8Ng4uCMVLicLWJytzx0rq6Hgn3P2TPMzIQLERfF2TmzTit14jPKDCcbTM/1+SjtpdO5XS5hEW3DWRC5SH/L0S4qXzXXSH4LwpjqmzzSRXvQxzD6BX6u7QGjrywEGR3R57jskcfNWTMfUAnJwHu/ugVlE0aFpssojzPp+PSnMMIUHNl9NvVICkoarybJZShIEmz8011AbI+8wVOet0pvhGRvbBZM8wDHVRXhy6hrCMPlAj2ujdjuvcvgOSb65kiGBKkew/7ChsWolIFJk+ifocYKRvQ0FKW/fjACBkaGwkpDyabYqCYNtOwj4mMJw7jfefic0vw57meXaY+xPWNeS1Ej/VG8CdijGWitHKPJbfG22utQDHd0adk5RoGrV5PCv3Nq682za3sJx/38YssidJpwED953D8tfY1rF2VtJDu6QyEvcCUDtG05pazYoa+y3M4Q43a9Xe8Df6R+Pk3M72oAn9bAiQfVAuidV/Kr1jvK3PjVX81nnY4visYi/zS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P192MB0721.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(366016)(376014)(1800799024)(18002099003)(8096899003)(4053099003)(38070700021)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mppRCC1HaWbvb5LS1q+172jXE9JsDie6zH1ffrL3kEAZ8E50La29hzz1Xp?=
 =?iso-8859-1?Q?Vzy5GjrwQzrQV0IudBnGcW98kEjxGXnvp1/THGlsMmP/n5aNTwJjZSwr1k?=
 =?iso-8859-1?Q?C3be5S2Hzr37gT4JZGW4lbnrjtzcL3i0tkmp0MdKYyhR/QAA1ijkP2AxUr?=
 =?iso-8859-1?Q?PVrqzPqnpGcFokvnNQtasGgN83fFFRuptZ0AR3ToDMMKR+uWbKcRMpPZR/?=
 =?iso-8859-1?Q?/7VBEHZw+9qPusGIawehE7DZmPweCqd36OhRugyYJZF7xeySqcL88qsTje?=
 =?iso-8859-1?Q?chmkdIZQfp37RbK1kE1jXJlm1ZYAwuiYA5uBia1ia0Ai+Ga11l5NDRBvYU?=
 =?iso-8859-1?Q?j1GN5HMUVymKK7AHidoVGWHQBZ0ZiJmYeIzPCidyaL4OG7AX7IchkFYhgZ?=
 =?iso-8859-1?Q?XGEB4T9qbaK5kqIzjPK8WRl0ZeA437amvLiJ5+J/ncfYp7zopwWnYpR2OW?=
 =?iso-8859-1?Q?Y2xeWSfmMkxq8SACFMuQCVS8A54JM0JvxigxF1Aj8aABEkt1QlDD/aNTr5?=
 =?iso-8859-1?Q?1tDaX5831LmwNHVjGwMEFYPQhf6OnR+NBmpFiBf9DelS3t29A+pVfLaEpz?=
 =?iso-8859-1?Q?up7CCxLIpul/Oxww0nlzRg3nA+FjK74cshUcsNMAn8XMNtZ70xLm4c79bo?=
 =?iso-8859-1?Q?IarDHtroZHQF7hd+K1w3KW98M8L7b6pc7CcIS1T3mn9tcCILu9jpg1k1hb?=
 =?iso-8859-1?Q?r40rF5Tv5dFF16Y+B9oLN/O40Slta/T7kceF5ieT9Gnoa/7n636HVltuld?=
 =?iso-8859-1?Q?MJ3Wby/6VuHJ1NG3edAlEJLsyGN6G6svS6EqHDovoD6gGTClXYPHOWJOUS?=
 =?iso-8859-1?Q?wOlGbDHhBSeHCxYIn+MgBxgunPllHK0OzANKssdmnG2uhqRXmB2bVjI5Wh?=
 =?iso-8859-1?Q?a213AIBQ9/Klvq1jDEpVhbL/YSPL6Fnjoqh92cU4CHuSdupZtESkcbOffc?=
 =?iso-8859-1?Q?1HV1vuDAeC04Z3FYnrplTJSCdi9BDXj13YGABxr4Y4xEGnF/5okoynWo4V?=
 =?iso-8859-1?Q?CAJQGVN9sUXlVgSfc2Y4zm+GSauoMxhOcYri9tqKTNBjjgw/LHs5ep9jEU?=
 =?iso-8859-1?Q?2XyUhKl9s07/ol5jKT4Ei1iI2lGAcGrBx9IA89UqEr3PbX3vIHm/TXcOka?=
 =?iso-8859-1?Q?NNWscJ5uYtU7E4wGuX0ANyv5fbuCIpBa2QnQEM8hLW19xeCwwM7EB+nwfd?=
 =?iso-8859-1?Q?nrmgWhUkumhpugX/symYD3Xzo6HElD9hVWarCLIVfifsd35LDK8MRkdtTX?=
 =?iso-8859-1?Q?lABl7jPtEPtc54/LDstIZHr1Uy8yS+cfN7hMeNJPMyYIi2OmUZ6R/ibm5L?=
 =?iso-8859-1?Q?t/n0iRx6L4ZaF7BokyTUiIuEspSkC9mzPP1fOGefUtOod4sgOhDrPStQnl?=
 =?iso-8859-1?Q?5wWF6pOyt49fDI7ZD/DZRepYiGJ26laRqunh2WZe4G7WnL8sSBK+UVdKiF?=
 =?iso-8859-1?Q?O/ewGY25vwJqR+gzxy9rI3qQu0Tko9utMfOYTazYY9RvaHOedgzMW/gAOD?=
 =?iso-8859-1?Q?pxfDvcQh6B4SAtBjXRM3jI3t8jE7YbhUoUon1ziF0HxsD9fbMfrsTKPBIv?=
 =?iso-8859-1?Q?DtqvtK4Se1FpnYk9hIbe81hgByPw82qoC2iSNDCwZzaw9LPTA4fo95cUtP?=
 =?iso-8859-1?Q?b2+QrHugmLp8kjKg3VWtwLZq1+iaDxKx7HcrqV4x009QFuZzwfp8OE55XC?=
 =?iso-8859-1?Q?8i7yRrlzcfCpBaienaUX69vqWtclGbJutVL6ryjsje0H8nhjCM4rIUxWxo?=
 =?iso-8859-1?Q?irBqqIIdT18xxIZrauDw1gGaQ1qHLfe/EnHeMeJTAgnpbo?=
Content-Type: multipart/mixed;
	boundary="_005_AM7P192MB0721CEAC90D73E5FE70EC5EED1072AM7P192MB0721EURP_"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	CztjdTvWgh8/Y4jUNh+axdfVhB+engern8Y/RbvojZ/6ykWW+BtQaXmAB+f4u7AxCX1OJqaT5UpVwol+Wgz6C6V7grRyu1xS9MtabbFlKzahNMiVv10tDXvqx0T7ZY80tBMDB9EuTnaKYXCO+FGL1+D7FsWS8uBO82h+IydOISB3h3H7eLuFpAHETlxY1FiVQlbZ3I+JjV6Fovv0I8hQs7J6TpAVILuWnTCUxdYcJe0QOb8cfHb+Tr78m+fKWRFN2P5J/HhBrfHaJFhhjsGMlJMVfQiR8JaPL7TAqAFvLW38RCazrBpVXtMN+Io4HDROZh4zCPiL/u+OvrOY7ve+/A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oVZdG1Pc9TbHIAJUtm5zsC3xFCmx4NfVoEq97c5qFPht5mybIruoTiqCfu1Leb6KEUhD1vUIcIXco/DvzoUpCwKnc/N/hkMLbsbQp6mOjSRwlAT3y/DbiYCuQmhQGIqDE5ZMfHVC8eT17H5QLlXhCbUbhlLa2aA5ybFNaJ/ngoFF7FJHiNCLnp3hnCONVdf3COUFNaUG1T3yBnz5jzR0R7TGKaDLlPES/3QEcRVZcyRA5nbMqj9OhtLzr8N+RlJkhbt+vXu0KixMQktjGztqIy9ooIRbtF5uaELcglohDFXMOqtj12pqtfeO779Y4IWcMeYOy6AqDWqlWV7ja8yy6ohMkzJazDoY2luL8vjJxnxv+TnP+IIaZBdhYzQ478f42jq0bfTa/j238WZ0tA3Dxk7nEAGRprWDe7TXeRbpgjHcE08EjDdFyQniqj3J9Ojvv2FyClZb/olUxbIDVl2q/XC+IDljcHiXN4M1Bv1uLoojOxuA+NV8VaQlevUnqTPnmOaONHuyRt411TMY8DdXDZJnt+0AE0FNSkS896PYgCso+1g6J81UFFeqoY00MSMApWk1BIq2QSr5Nla1HnaMobK9qp8QH4hdsIEGWC84M1IMk4IEeTucnU0YV892PiQl
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P192MB0721.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 26aa26ac-395a-4064-e53e-08deb1fd358f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 21:10:21.6262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UhACn9zJ0gnYzQSSeiVcYGQf8AOtNfhVnPkseSCU18QMo/GD+Uv2CoLXEKc1l8JAl2DFCE9WWfnxA4LIACEM9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1975
X-cloud-security-sender:tnizan@witekio.com
X-cloud-security-recipient:linux-can@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: tnizan@witekio.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-gate07-hz12 with 4gGjfB3Y9Hz1b0bJ
X-cloud-security-connect: mail-westeuropeazon11023121.outbound.protection.outlook.com[52.101.72.121], TLS=1, IP=52.101.72.121
X-cloud-security-Digest:3d1a29ef92cc68d5b143c9af10934b4b
X-cloud-security:scantime:1.472
X-Rspamd-Queue-Id: F02D9546F1C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	MIME_BAD_ATTACHMENT(1.60)[c:text/x-csrc];
	ARC_REJECT(1.00)[cv is fail on i=3];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[witekio.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[witekio.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain,text/x-patch,text/x-csrc];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7629-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[witekio.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tnizan@witekio.com,linux-can@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:+,5:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

--_005_AM7P192MB0721CEAC90D73E5FE70EC5EED1072AM7P192MB0721EURP_
Content-Type: multipart/alternative;
	boundary="_000_AM7P192MB0721CEAC90D73E5FE70EC5EED1072AM7P192MB0721EURP_"

--_000_AM7P192MB0721CEAC90D73E5FE70EC5EED1072AM7P192MB0721EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Chandrasekar,
I am observing what looks like a bus-off recovery issue in the m_can driver=
 since commit e668673 ("can: m_can: Use the workqueue as queue"). The issue=
 is still present in current master.
Setup:

  *   TI K3 J784S4 SoC running Linux with the m_can controller enabled
  *   The CAN interface is connected directly to a Linux PC through a stand=
ard CAN transceiver setup
  *   Both sides are configured identically using:
ip link set can0 type can bitrate 250000
ip link set can0 type can restart-ms 100
  *   Continuous CAN TX traffic is generated from userspace on the J784S4 s=
ide using a simple SocketCAN application that continuously writes frames
  *   During transmission, the CANH/CANL lines are physically shorted to fo=
rce the controller into bus-off
  *   The short is then removed to observe the automatic recovery and TX re=
start behavior

Issue description:
If the CAN bus is shorted only briefly, recovery works correctly once the s=
hort is removed.
However, if the interface stays in bus-off for a longer period while usersp=
ace continues writing frames to the socket, the interface eventually stops =
transmitting permanently. After removing the short, the application only ge=
ts:

  *   Resource temporarily unavailable

and no more TX attempts occur.
From debugging, it looks like the TX path eventually stops being retriggere=
d after repeated restart cycles.
I traced this to the BUS_OFF handling in m_can_start_xmit():

if (cdev->can.state =3D=3D CAN_STATE_BUS_OFF) {
        return NETDEV_TX_OK;
}

Removing this block entirely seems to fix the issue in my testing, includin=
g after prolonged bus-off conditions and repeated restart cycles.

I attached:

  *   the small userspace stress program used to reproduce the issue (test_=
can_send.c)
  *   the experimental patch

My CAN framework knowledge is limited, so the proposed fix may not be the m=
ost appropriate solution, but I wanted to report the behavior in case this =
indicates a regression introduced by the workqueue conversion.

Let me know if you need more information.
Best regards,
Thomas Nizan

--_000_AM7P192MB0721CEAC90D73E5FE70EC5EED1072AM7P192MB0721EURP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
Hi Chandrasekar,</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
I am observing what looks like a bus-off recovery issue in the m_can driver=
 since commit
<code>e668673</code>&nbsp;(&quot;can: m_can: Use the workqueue as queue&quo=
t;). The issue is still present in current master.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
Setup:</div>
<ul data-spread=3D"false">
<li style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apto=
s_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; col=
or: rgb(0, 0, 0);">
TI K3 J784S4 SoC running Linux with the m_can&nbsp;controller enabled</li><=
li style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos=
_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; colo=
r: rgb(0, 0, 0);">
The CAN interface is connected directly to a Linux PC through a standard CA=
N transceiver setup</li><li style=3D"font-family: Aptos, &quot;Aptos_Embedd=
edFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-ser=
if; font-size: 12pt; color: rgb(0, 0, 0);">
Both sides are configured identically using:<br>
<code>ip link set can0 type can bitrate 250000</code><br>
<code>ip link set can0 type can restart-ms 100</code></li><li style=3D"font=
-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&q=
uot;, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">
Continuous CAN TX traffic is generated from userspace on the J784S4 side us=
ing a simple SocketCAN application that continuously writes frames</li><li =
style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MS=
FontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; color: =
rgb(0, 0, 0);">
During transmission, the CANH/CANL lines are physically shorted to force th=
e controller into bus-off</li><li style=3D"font-family: Aptos, &quot;Aptos_=
EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sa=
ns-serif; font-size: 12pt; color: rgb(0, 0, 0);">
The short is then removed to observe the automatic recovery and TX restart =
behavior</li></ul>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
<br>
</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
Issue description:<br>
If the&nbsp;CAN bus is shorted only briefly, recovery works correctly once =
the short is removed.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
However, if the interface stays in bus-off for a longer period while usersp=
ace continues writing frames to the socket, the interface eventually stops =
transmitting permanently. After removing the short, the application only ge=
ts:</div>
<ul data-spread=3D"false">
<li style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apto=
s_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; col=
or: rgb(0, 0, 0);">
<code>Resource temporarily unavailable</code></li></ul>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
and&nbsp;no more TX attempts occur.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
From debugging, it looks like the TX path eventually stops being retriggere=
d after repeated restart cycles.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
I traced this to the BUS_OFF handling in <code>m_can_start_xmit()</code>:</=
div>
<pre class=3D"elementToProof"><div style=3D"direction: ltr; font-family: Ap=
tos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calib=
ri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"=
elementToProof"><code>if (cdev-&gt;can.state =3D=3D CAN_STATE_BUS_OFF) {=0A=
 &nbsp; &nbsp; &nbsp; &nbsp;return NETDEV_TX_OK;=0A=
}</code></div></pre>
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">
Removing this block entirely seems to fix the issue in my testing, includin=
g after prolonged bus-off conditions and repeated restart cycles.</div>
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
I attached:</div>
<ul data-spread=3D"false">
<li style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apto=
s_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; col=
or: rgb(0, 0, 0);">
the small userspace stress program used to reproduce the issue (<code>test_=
can_send.c</code>)</li><li style=3D"font-family: Aptos, &quot;Aptos_Embedde=
dFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);">
the experimental patch</li></ul>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
My CAN framework knowledge is limited, so the proposed fix may not be the m=
ost appropriate solution, but I wanted to report the behavior in case this =
indicates a regression introduced by the workqueue conversion.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
<br>
</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
Let me know if you need more information.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
Best regards,<br>
Thomas Nizan</div>
</body>
</html>

--_000_AM7P192MB0721CEAC90D73E5FE70EC5EED1072AM7P192MB0721EURP_--

--_005_AM7P192MB0721CEAC90D73E5FE70EC5EED1072AM7P192MB0721EURP_
Content-Type: text/x-patch; name="0001-m_can-bus-off-recovery-fix.patch"
Content-Description: 0001-m_can-bus-off-recovery-fix.patch
Content-Disposition: attachment;
	filename="0001-m_can-bus-off-recovery-fix.patch"; size=822;
	creation-date="Thu, 14 May 2026 21:05:14 GMT";
	modification-date="Thu, 14 May 2026 21:07:15 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkYjE0Yjg0ZmYyOTNmYzA1MzU4MGU1NWUxZDNhMGVkNDIyZGY1NDU0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaG9tYXMgTml6YW4gPHRuaXphbkB3aXRla2lvLmNvbT4KRGF0
ZTogVGh1LCAxNCBNYXkgMjAyNiAxMzo1MToxNCAtMDcwMApTdWJqZWN0OiBbUEFUQ0hdIG1fY2Fu
OiBidXMtb2ZmIHJlY292ZXJ5IGZpeAoKU2lnbmVkLW9mZi1ieTogVGhvbWFzIE5pemFuIDx0bml6
YW5Ad2l0ZWtpby5jb20+Ci0tLQogZHJpdmVycy9uZXQvY2FuL21fY2FuL21fY2FuLmMgfCA1IC0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9jYW4vbV9jYW4vbV9jYW4uYyBiL2RyaXZlcnMvbmV0L2Nhbi9tX2Nhbi9tX2Nhbi5jCmlu
ZGV4IGViODU2NTQ3YWU3ZC4uNmQwYjMwYzE4MGJmIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC9j
YW4vbV9jYW4vbV9jYW4uYworKysgYi9kcml2ZXJzL25ldC9jYW4vbV9jYW4vbV9jYW4uYwpAQCAt
MjAzNSwxMSArMjAzNSw2IEBAIHN0YXRpYyBuZXRkZXZfdHhfdCBtX2Nhbl9zdGFydF94bWl0KHN0
cnVjdCBza19idWZmICpza2IsCiAKIAlmcmFtZV9sZW4gPSBjYW5fc2tiX2dldF9mcmFtZV9sZW4o
c2tiKTsKIAotCWlmIChjZGV2LT5jYW4uc3RhdGUgPT0gQ0FOX1NUQVRFX0JVU19PRkYpIHsKLQkJ
bV9jYW5fY2xlYW4oY2Rldi0+bmV0KTsKLQkJcmV0dXJuIE5FVERFVl9UWF9PSzsKLQl9Ci0KIAly
ZXQgPSBtX2Nhbl9zdGFydF90eChjZGV2KTsKIAlpZiAocmV0ICE9IE5FVERFVl9UWF9PSykKIAkJ
cmV0dXJuIHJldDsKLS0gCjIuNDMuMAoK

--_005_AM7P192MB0721CEAC90D73E5FE70EC5EED1072AM7P192MB0721EURP_
Content-Type: text/x-csrc; name="test_can_send.c"
Content-Description: test_can_send.c
Content-Disposition: attachment; filename="test_can_send.c"; size=2642;
	creation-date="Thu, 14 May 2026 21:06:51 GMT";
	modification-date="Thu, 14 May 2026 21:07:15 GMT"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN5cy9zb2NrZXQuaD4KI2luY2x1ZGUgPHN5cy90eXBlcy5oPgojaW5jbHVkZSA8
c3lzL2lvY3RsLmg+CiNpbmNsdWRlIDxuZXQvaWYuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5j
bHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGludC5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNp
bmNsdWRlIDxlcnJuby5oPgojaW5jbHVkZSA8c2lnbmFsLmg+CiNpbmNsdWRlIDxmY250bC5oPgoj
aW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHRpbWUuaD4K
I2luY2x1ZGUgPGxpbnV4L2Nhbi5oPgojaW5jbHVkZSA8bGludXgvY2FuL3Jhdy5oPgojaW5jbHVk
ZSA8bGludXgvY2FuL2Vycm9yLmg+CgppbnQgc2VuZF9zb2NrOwoKaW50IG9wZW5fc29ja2V0KHZv
aWQpCnsKCWNoYXIgY2FuX2ludGVyZmFjZV9zdHJbNV0gPSAiY2FuMCI7CglpbnQgZmxhZ3M7Cglz
dHJ1Y3Qgc29ja2FkZHJfY2FuIGFkZHI7CglzdHJ1Y3QgaWZyZXEgaWZyOwogICBpbnQgZXJyb3Jf
Y29kZTsKCglzZW5kX3NvY2sgPSBzb2NrZXQoUEZfQ0FOLCBTT0NLX1JBVywgQ0FOX1JBVyk7Cglp
ZiAoc2VuZF9zb2NrIDwgMCkgewoJCXBlcnJvcigwKTsKCQlyZXR1cm4gLTU7Cgl9CgoJZmxhZ3Mg
PSBmY250bChzZW5kX3NvY2ssIEZfR0VURkwpOwoJZmNudGwoc2VuZF9zb2NrLCBGX1NFVEZMLCBm
bGFncyB8IE9fTk9OQkxPQ0spOwoKCXN0cmNweShpZnIuaWZyX25hbWUsIGNhbl9pbnRlcmZhY2Vf
c3RyKTsKCWlvY3RsKHNlbmRfc29jaywgU0lPQ0dJRklOREVYLCAmaWZyKTsKCglhZGRyLmNhbl9m
YW1pbHkgPSBBRl9DQU47CglhZGRyLmNhbl9pZmluZGV4ID0gaWZyLmlmcl9pZmluZGV4OwoKCWVy
cm9yX2NvZGUgPSBiaW5kKHNlbmRfc29jaywgKHN0cnVjdCBzb2NrYWRkciAqKSZhZGRyLCBzaXpl
b2YoYWRkcikpOwoJaWYgKGVycm9yX2NvZGUgPCAwKSB7CgkJcGVycm9yKDApOwoJCXJldHVybiAt
NjsKCX0KCXNlbmRfc29jayA9IHNvY2tldChQRl9DQU4sIFNPQ0tfUkFXLCBDQU5fUkFXKTsKCWlm
IChzZW5kX3NvY2sgPCAwKSB7CgkJcGVycm9yKDApOwoJCXJldHVybiAtNTsKCX0KCglmbGFncyA9
IGZjbnRsKHNlbmRfc29jaywgRl9HRVRGTCk7CglmY250bChzZW5kX3NvY2ssIEZfU0VURkwsIGZs
YWdzIHwgT19OT05CTE9DSyk7CgoJc3RyY3B5KGlmci5pZnJfbmFtZSwgY2FuX2ludGVyZmFjZV9z
dHIpOwoJaW9jdGwoc2VuZF9zb2NrLCBTSU9DR0lGSU5ERVgsICZpZnIpOwoKCWFkZHIuY2FuX2Zh
bWlseSA9IEFGX0NBTjsKCWFkZHIuY2FuX2lmaW5kZXggPSBpZnIuaWZyX2lmaW5kZXg7CgoJZXJy
b3JfY29kZSA9IGJpbmQoc2VuZF9zb2NrLCAoc3RydWN0IHNvY2thZGRyICopJmFkZHIsIHNpemVv
ZihhZGRyKSk7CglpZiAoZXJyb3JfY29kZSA8IDApIHsKCQlwZXJyb3IoMCk7CgkJcmV0dXJuIC02
OwoJfQogICByZXR1cm4gMDsKfQoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKewoJ
dWludDY0X3QgY2FuX2lkOwoJdWludDY0X3QgY2FuX21lc3NhZ2U7CglzdHJ1Y3QgY2FuX2ZyYW1l
IGZyYW1lOwoJaW50IGVycm9yX2NvZGU7CglpbnQgaTsKCXN0cnVjdCB0aW1lc3BlYyBzcGVjOwoK
CWNhbl9pZCA9IDA7CgogICBpZiAoIChlcnJvcl9jb2RlID0gb3Blbl9zb2NrZXQoKSkgPCAwICkg
cmV0dXJuIGVycm9yX2NvZGU7CgoJZnJhbWUuY2FuX2lkID0gY2FuX2lkOwoJZnJhbWUuY2FuX2lk
IHw9IENBTl9FRkZfRkxBRzsKCWZyYW1lLmNhbl9kbGMgPSA4OwoKICAgbWVtc2V0KGZyYW1lLmRh
dGEsIDAsIDgpOwoKICAgd2hpbGUgKDEpCiAgIHsKICAgICAgZm9yIChpPTA7IGk8MTA7IGkrKykK
ICAgICAgewogICAgICAgICBjbG9ja19nZXR0aW1lKENMT0NLX1JFQUxUSU1FLCAmc3BlYyk7CiAg
ICAgICAgIGVycm9yX2NvZGUgPSBzZW5kKHNlbmRfc29jaywgJmZyYW1lLCBzaXplb2Yoc3RydWN0
IGNhbl9mcmFtZSksIE1TR19ET05UV0FJVCk7CiAgICAgICAgIGlmIChlcnJvcl9jb2RlIDwgMCkK
ICAgICAgICAgewogICAgICAgICAgICBwZXJyb3IoMCk7CiNpZiAwCiAgICAgICAgICAgIGlmICgg
KGVycm5vID09IEVOT0JVRlMpIHx8IChlcnJubyA9PSBFQUdBSU4pICkKICAgICAgICAgICAgewog
ICAgICAgICAgICAgICBjbG9zZShzZW5kX3NvY2spOwogICAgICAgICAgICAgICBpZiAoIChlcnJv
cl9jb2RlID0gb3Blbl9zb2NrZXQoKSkgPCAwICkgcmV0dXJuIGVycm9yX2NvZGU7CiAgICAgICAg
ICAgICAgIHByaW50ZigiQ2xvc2luZyBhbmQgb3BlbmluZyBzb2NrZXQuXG4iKTsKICAgICAgICAg
ICAgfQojZW5kaWYKICAgICAgICAgfQogICAgICAgICBlbHNlCiAgICAgICAgIHsKICAgICAgICAg
ICAgcHJpbnRmKCIlbGxkLiUwOWxkOiAgaWQ9MHglMDh4IGxlbj0leCBtc2dbMF09JXhcbiIsIChs
b25nIGxvbmcpc3BlYy50dl9zZWMsIHNwZWMudHZfbnNlYywgKGZyYW1lLmNhbl9pZCAmIDB4MUZG
RkZGRkYpLCBmcmFtZS5jYW5fZGxjLCBmcmFtZS5kYXRhWzBdKTsKICAgICAgICAgfQogICAgICAg
IAogICAgICAgICBmcmFtZS5jYW5faWQrKzsKICAgICAgICAgZnJhbWUuZGF0YVswXSA9IGZyYW1l
LmNhbl9pZDsKICAgICAgfQogICAgICB1c2xlZXAoMTAwMDApOwogICB9CgoJY2xvc2Uoc2VuZF9z
b2NrKTsKCglyZXR1cm4gMDsKfQo=

--_005_AM7P192MB0721CEAC90D73E5FE70EC5EED1072AM7P192MB0721EURP_--


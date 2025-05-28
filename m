Return-Path: <linux-can+bounces-3714-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA22AC6361
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 09:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C4077AC77C
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 07:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67692441B8;
	Wed, 28 May 2025 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hms-networks.com header.i=@hms-networks.com header.b="mDLoiYrh"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2099.outbound.protection.outlook.com [40.107.105.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433D620013A
	for <linux-can@vger.kernel.org>; Wed, 28 May 2025 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748418726; cv=fail; b=fLVrAme79IsYVxgIVPEuni5KVg8+Z5Qoi4+sBhbjt+albnKRrlv0sVHEDuswN74Dmya3smnnE33uBFnRJk5mZA/GDGHU23uesyVBYKEjYnmzTMOtensSCtZW+Vqn5BfjhsUFRj1xrdlBYQRFI97NLRoyg36gAIX7BjW4gEm8mEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748418726; c=relaxed/simple;
	bh=bd4tcxWfuqkPO94haN2ly297fO9APGVujzyyGVaP4x4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E1L0SM53SECrVwTZj1M85/ZzFKzz7W+bS1Yk6OqhwXJfc1SjUaFU2V1vuPkU/TtncacU96sVXh/6aCiEY4yWMjM9tSTVSbqhLDm4coUn3VfkQA31BHhw6Uh7ufQ3Jeq//pPm9VBZl06mdXPCraU/0y/HkvD013KbvBooppxqqA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hms-networks.com; spf=pass smtp.mailfrom=hms-networks.com; dkim=pass (2048-bit key) header.d=hms-networks.com header.i=@hms-networks.com header.b=mDLoiYrh; arc=fail smtp.client-ip=40.107.105.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hms-networks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hms-networks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuyDotf47AdrxHomb+KiUjVb8GcZnvPTD/Ot1RSbGCDnE4WEQ4b0teRyyrqRlrbKGk164dqSytsdIe0Hh+0KUp4QkR0F9W/OSzFx/D5gWXwlje7+UyCfYDlRE5PHcAatN3Veh6GdPGC/j/HsL56KN8hccGHmIaHDinFExfp5lHuZ8PcmpIbFvYXpqu9J0fWPp7dEFQmqqRcPAjWDi3WiE44xlY+Cx66JxM+RnIpNzBhSuZzvsBFAC4fh22nYLyzpCeVxed6cMuJMZ3GvM7w8g0NVpljuJSQIyP9dv02P0S2p0tB7FIK6WD1vqsXHfV+FfEBEQtJ74KOWZAsJNd8oSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bd4tcxWfuqkPO94haN2ly297fO9APGVujzyyGVaP4x4=;
 b=CvNw43qMRVJzXx2sFLMfMSqCJ47yjLnZYsG991no3gu6m0AIUQ0r4GzLMT2TEU/gMdccnpL+V4SZkROUFiHnfpGo1zWkxIsmVhc3sZI+Gfhapc4G2WaW7wf3La/tnfWQZrbI8O4OIjdxgX/veO9Y6L2RA7yOcMRmkw2Pajz4ic01s2uZfZwk8rPVXqn6sxLhDscoiMyFeeBfdp400XiMYKFG+ECFySd0WuRchMPp4hBGbdcIHLZlN5CeRDetyAdJRpR2k3uimuF3ABp8jFyGGayf0RYKWefs/zXMlTDNu2TYBE3uJ8BGKlJbhEw2oX169QbfJoLzwh9UivDiGDAevQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hms-networks.com; dmarc=pass action=none
 header.from=hms-networks.com; dkim=pass header.d=hms-networks.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hms-networks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bd4tcxWfuqkPO94haN2ly297fO9APGVujzyyGVaP4x4=;
 b=mDLoiYrhbR2tmKYCgxhxoti6nRhyqPd6HNblC5UbfNqyCn2VFzzLuEGSl7d4UgIKCOxias+6abDtDwBKfoEAFC9OLqlEhJSb7dkTpvYv1RxSwYOUTv8ZljnKlREzZ14bWgm/abcsGdX7lKwcecBx0LFYm1SwXgTIv2Zi/rsrR7HQeUzwePz6/opMlIQ3UR49uLYbhb4N47rfk9w+TADB35wMPWFBLmYhS7fv1hSlRi5V+Qq2ob9lAgJPY+wIToCKXMrAMYPJoBgQY3O7howyD5RNhtT8B8cbpr7DXkvGgj/9+nYLt+RvAtFjOaAuYX5eKBlT3AHIx2DaPkZTuGt2lQ==
Received: from DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1cd::16)
 by AS8PR10MB7562.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:53e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 07:51:59 +0000
Received: from DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac8a:512d:4cd7:1bb6]) by DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac8a:512d:4cd7:1bb6%3]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 07:51:59 +0000
From: =?Windows-1252?Q?St=E9phane_Grosjean?=
	<stephane.grosjean@hms-networks.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Oliver Hartkopp
	<socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: TR: can: canxl: about CAN_CTRLMODE_XL_ERR_SIGNAL 
Thread-Topic: can: canxl: about CAN_CTRLMODE_XL_ERR_SIGNAL 
Thread-Index: AQHbz6T3UHfo4SMCp0qA1TMli15IbLPnqvAw
Date: Wed, 28 May 2025 07:51:59 +0000
Message-ID:
 <DBAPR10MB41879125DC7369359E4AB256D467A@DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM>
References:
 <DBAPR10MB4187FB44B12BD9DB8B992256D4832@DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM>
 <06bd3b3f-2665-4f19-b13d-581e57f54dfc@hartkopp.net>
 <AM9PR10MB4184729E14AD5C05ABC65718D496A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <1c502316-ddee-4f12-b0b8-3725cc522591@hartkopp.net>
 <AM9PR10MB418448751B1DA83EED7F50D4D498A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <63f2f51e-3fbd-4c8b-b7e4-29cb55246eaf@hartkopp.net>
 <AM9PR10MB41846346BC291F7CFE2CB71DD498A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <49245439-9822-449d-bf2c-5626349d909c@hartkopp.net>
 <20250527-lilac-panther-of-destiny-a13500-mkl@pengutronix.de>
 <AM9PR10MB4184E0842D24A4D7A2FEE09BD464A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <20250527-glistening-dog-of-apotheosis-293bd2-mkl@pengutronix.de>
 <04a7058c-95c7-4adc-a447-423aec0e0077@hartkopp.net>
 <DBAPR10MB418777613B630B9F72E20008D467A@DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To:
 <DBAPR10MB418777613B630B9F72E20008D467A@DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hms-networks.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBAPR10MB4187:EE_|AS8PR10MB7562:EE_
x-ms-office365-filtering-correlation-id: c4ead080-704b-4f07-2ef7-08dd9dbc8678
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?pGTAwz1+spjbKl1GtgK86KcoWP7sT3ap0zXVkFlvQ5AJsT5lV/maeyzt?=
 =?Windows-1252?Q?yQXB4UnfzBMNk8WyXjA0Le8GXKKMw/r0X7vySHtpRCptpbzY8GuB0zAM?=
 =?Windows-1252?Q?1ciQ+r4Nq8oR2JJXZxOpIne1ukRIo0wqyYjUZlbZ3w51ttpd2KSnlPsf?=
 =?Windows-1252?Q?4epptcW0RvAEuFU4mSYi+W/uBb3noPNpSlYRP8tWDEO5AGdG57/JyImA?=
 =?Windows-1252?Q?mpOFwoX1Ee32a6HSg2Fb0jLPBPq/hrvikT1L0uJiXdKquR/BIBi4nXp0?=
 =?Windows-1252?Q?S0wlohYJv/1kap+jgV9sfLAb4sHY6GAn9Qq0zCSXUIRVGBEaGpR/+x5x?=
 =?Windows-1252?Q?Cj/VeIREK3U+VvLvSLBRe1EbU0KkRTjMGXIKM06865hmwPeZXxctnN4A?=
 =?Windows-1252?Q?k6KXQi23m86vvyjEjWUtxVzOzO2GUgk6Vr/O1fJLf2LLV8AtpKkTMohK?=
 =?Windows-1252?Q?A7nYQtMtHRv2oXpFyUUC1kzJlnGlZn6qPc4nWThtcdOG3/FWtVAJBn+R?=
 =?Windows-1252?Q?drYfnt+Z7w+5nGdYmT0KB+m7DDKiSxgK8/V5OcY9mRfr3TAOfgBT7JhM?=
 =?Windows-1252?Q?ZQx52uK86IJHdi6kcKHuzcvBJ88bJaPu9iRmcRY5hcJuQm/NmNWYDVY/?=
 =?Windows-1252?Q?dLEJJnehepRl7V+vQf3DAOcyLi0WZzflfS1YsAUZErzBhKbNCzMqEM+o?=
 =?Windows-1252?Q?k2NvhhHU8MH/sFeahR8kpPnQv+e/9e3o81cgFMhmjuSRgImAUWzsdamO?=
 =?Windows-1252?Q?X9VHDtjawqcIclo4s940sj0Voodm71uLZu9wQzCaOtyrbFGXffJuF+9k?=
 =?Windows-1252?Q?jy5X3l1hyhwBmRG1DN9Esvais6ThxbBYqIFAyEzZxir+Rp8no0VArgza?=
 =?Windows-1252?Q?fXj8XnlnWDPQasI5LFtodDKpniO5a7mRCRoXuZxQkMZok/7jv+YlJgIu?=
 =?Windows-1252?Q?5ykhavPPEaZimB9hX74h83EuiWgZoWxg3PdJhRH6OUKUQKbQexyqNLz/?=
 =?Windows-1252?Q?9981sFgqfz5whFYzM50guKgtk+Nvx9yoijlTNC2xwDycxUqaDt0oq103?=
 =?Windows-1252?Q?TBXfHUsUaXIHxrkzFOn3+6R7iskbmAvbArYshMFnz6uDI95OpamtIZke?=
 =?Windows-1252?Q?sfzJ+Ql20P55EasjJa060g1R/nkql352wh0vj+0RwFGFCgxHDlG1gVEd?=
 =?Windows-1252?Q?y9JHAJKQLAFjjWLgwrIZu7Tdvyqv6ImJNitPPNDCZqWkBRKteJ7Ged0C?=
 =?Windows-1252?Q?zOtZKmm0LyHTqn+94ZQfaEyzoesUQWDgpoVqSRJnE8ZLXg+6dxQMueaS?=
 =?Windows-1252?Q?p1Ngf3Az7TbspzMNt5R6fkKfyDlqqbSN58ivADGhZhBuC5TDfqUeg9o5?=
 =?Windows-1252?Q?e2yJP1dpty0ooYUfFE+imbvNjkc4b0nvYGDDuaK0h8e2d+bJToLOhNaH?=
 =?Windows-1252?Q?fy1DojlyLkvRlIW823UVDos6Rhw4EIUTpNtcVst4H3u71ZOmZ8tWRd2J?=
 =?Windows-1252?Q?YIOgsx1h8l+nFQh+Jyoe/FC8lljRz66bjvXwsCL80AszQvtD1F8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?kp31Mf/avyf6Ezfqmw1oKG2jl9Xhttcp0RV+Vjg/cVU1+/i/9t5wUn2n?=
 =?Windows-1252?Q?c+ZCI3T/p34w5JXNvgcRV91yx+nuF2Nff2JL+eki3Rtfhfxd2MXCNSnI?=
 =?Windows-1252?Q?LLMrWIq2rNzk3rENGo4Q/LJ97s4paO+6ic2BSnoImmh+kmoXWEQkmnKM?=
 =?Windows-1252?Q?s+c8KILpoisuWcMftdx7k5UHELffe+rFACVFWdz953byTaZ86STO2Oye?=
 =?Windows-1252?Q?5HIkmRBC1wJImXZNwg+LJjHP1YclKGiYbwXbEgix1qiQTXqueU1pwdgD?=
 =?Windows-1252?Q?Lybd4L6sDbkMi8Kn3OAz9EGZ6wjiVhyxV23I6vYLpg5ciLtij/s3J5Hs?=
 =?Windows-1252?Q?bA0rxemv9XjpRD6NkBKqD9C/meE7L4HDf1xwd+qF6wiQUs7KZeUu80s6?=
 =?Windows-1252?Q?xNxtAr9l/aOiPjeFA8XeVMo8vzr/lql6wwMep69YKduAddUO67VMtpuI?=
 =?Windows-1252?Q?czppbcGdhCpjyK2sJc3vNNCn1hiabaVIQx7LWZNEXVlfmdNlx/6gRH7e?=
 =?Windows-1252?Q?wrjLTJhtt3e/q4YF3xMN8VYHicyI1iU/k9rktt1ch/ePEui/hwGZd6GA?=
 =?Windows-1252?Q?AcPi+0IKhMXP/75TFHTxpe9cISlggniVWz6HISa12L/ywVk0vg32xbri?=
 =?Windows-1252?Q?60/+avy9/IsTX8NDscdXj8DXFxgZen8q6bpJztAnTGr/lLm9w7HCPa+I?=
 =?Windows-1252?Q?tow5fTo60ASxZahNYu50T2GahjW7uwA8ZfmKM/ZO4KVhHTD/SV5HfjxH?=
 =?Windows-1252?Q?uhj6UV17yh3VGPiZsHlA5386k0QBA7g9Vc7GAupwvN2AKcYkrBvkMTDd?=
 =?Windows-1252?Q?9rEvmqIiW4DYmhTQNrzqwBkNEojH1idk5mwvneR5w/fajWxuo7GrMDua?=
 =?Windows-1252?Q?l8YLvJ6l0tbWjHaoRpZbR79X6h7H/BQlM/6u9cu8rAD201V35exKjUh3?=
 =?Windows-1252?Q?b4sLf1W+dnoPF4G5Xcy5YL+wzWMjiKhVnsZQcF5I/q+gK6aWkcqeuLGh?=
 =?Windows-1252?Q?aB1CdbjQz/9iAf83aE7RAx6lsynGuGoMgWIb8UHUiGYntvXBkwXIETGk?=
 =?Windows-1252?Q?RfKLJcJkOcbpmfnuOE2DwQfelEByrNNe+UKAVI2fm4UILvVeN3980v+D?=
 =?Windows-1252?Q?j4jepMr9IGbQIRjeioc5YVZvDwNoeyUr1HmO3fojmNIHjBEkfgJYcXOG?=
 =?Windows-1252?Q?AaIxbiYKF5cN0wiMVCOJhtRKXmH7krHw2pQi29X8CNaVMD31NgVXyKcd?=
 =?Windows-1252?Q?TMGqbQTPOPI71A3FmyyvktRgm5ym8Zsxv7hUQeWYs4zBa9W5hBS0qlXX?=
 =?Windows-1252?Q?92uiaCN86s93WWPeavwjNCoIuRydks/cN25DNwCYoxMLQWiEGHzPZbMb?=
 =?Windows-1252?Q?JRpwUjW20sxJhkgq9rdxYhzojX3cnacJkdzm5MIWDGwDxvTHREzMr3Hk?=
 =?Windows-1252?Q?fBjIdN6kBOCeBOY82BxcWuGoFYL+S4dvYbdJ6bleCGNhfDIR4bPEkZkt?=
 =?Windows-1252?Q?KOmWZzFW5s1bAvc59XHeonkNeUX3Kl+rSp7IvNBlorcBOLIwz8RS364N?=
 =?Windows-1252?Q?PxlUFkLOnJXQ2oFTQ5KjV1uQYojZoeo4nVFi1DKHoWSPQZ7AmHChrQGn?=
 =?Windows-1252?Q?rT6YDwm6VNIH4vWqeiptI86TRNMhAqX9AKHCwJUBrXIKsXcxeYmdKR1k?=
 =?Windows-1252?Q?L5iiGnFTkp3ux4Z9AeYUVxLPF0ihxbXJDoN07vW45JEwVeuDwzjwACW4?=
 =?Windows-1252?Q?Vc7MNgVU42j3lrOuAJM=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hms-networks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ead080-704b-4f07-2ef7-08dd9dbc8678
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 07:51:59.1783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7c1590-4488-4e42-bc9c-15218f8ac994
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gc67ZzD2uKFjTwWEQiZPa1rstlMQlkr7PW40HXSkLkmUw3pvsOE5TUsUcaVGKX1J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7562

Hi,=0A=
=0A=
refs:=0A=
[1] https://www.bosch-semiconductors.com/media/ip_modules/pdf_2/can_xl_1/20=
220825_can_xl_vs_10base-t1s_v2.pdf=0A=
[2] https://github.com/hartkopp/canxl-nl/blob/main/linux/0009-can-canxl-sup=
port-CAN-XL-error-signalling-switching.patch=0A=
[3] https://github.com/hartkopp/canxl-nl/blob/main/linux/0011-can-add-CAN-X=
L-dummy-driver-DO-NOT-MERGE.patch=0A=
=0A=
According to [1] on page 6, the mixed-CANXL mode (island 1) allows joint op=
eration (aka CAN bus sharing) of CANFD and CANXL devices. This mode require=
s activation of the so-called =93error signaling=94 mode.=0A=
=0A=
Still according to [1] on page 6, the pure-CANXL mode (island 2) enables ex=
clusive operation of CANXL devices on the same bus and is obtained by disab=
ling the =93error signaling=94 mode.=0A=
=0A=
According to [3] lines 170-184, the CAN_CTRLMODE_FD and CAN_CTRLMODE_XL fla=
gs are not mutually exclusive, so why introduce CAN_CTRLMODE_XL_ERR_SIGNAL =
[2] when the combinations of CAN_CTRLMODE_FD and CAN_CTRLMODE_XL would allo=
w us to deduce this?=0A=
=0A=
Indeed:=0A=
=0A=
can_priv->ctrlmode & (CAN_CTRLMODE_FD|CAN_CTRLMODE_XL) =3D=3D=0A=
=0A=
CAN_CTRLMODE_FD=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CANFD mode (n/a)=0A=
CAN_CTRLMODE_XL|CAN_CTRLMODE_FD =A0 =A0mixed-CANXL =3D> error_signaling=3DO=
N=0A=
CAN_CTRLMODE_XL=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pure-CANXL =3D> erro=
r_signaling=3DOFF=0A=
=0A=
Regards,=0A=
=0A=
St=E9phane=0A=
=0A=
________________________________________=0A=
De :=A0Oliver Hartkopp <socketcan@hartkopp.net>=0A=
Envoy=E9 :=A0mardi 27 mai 2025 21:55=0A=
=C0 :=A0Marc Kleine-Budde <mkl@pengutronix.de>; St=E9phane Grosjean <stepha=
ne.grosjean@hms-networks.com>; Vincent Mailhol <mailhol.vincent@wanadoo.fr>=
=0A=
Cc=A0:=A0linux-can@vger.kernel.org <linux-can@vger.kernel.org>=0A=
Objet :=A0Latest patches - Re: CAN XL netlink AIP status=0A=
=A0=0A=
Hi all,=0A=
=0A=
I uploaded the latest work on this GitHub repo where you three (in To:)=0A=
are requested as collaborators:=0A=
=0A=
https://github.com/hartkopp/canxl-nl=0A=
=0A=
Additionally I will send the patches for iproute2 and the Linux kernel=0A=
here on the mailing list for further discussions.=0A=
=0A=
This is the commit message from the GitHub commit:=0A=
=0A=
=A0 =A0 Add initial patch sets for netlink CAN XL support=0A=
=0A=
=A0 =A0 Based on patches from Vincent Mailhol and Oliver Hartkopp.=0A=
=0A=
=A0 =A0 iproute2: patches based on iproute2 6.15=0A=
=A0 =A0 linux: patches based on linux 6.15 (mainline)=0A=
=0A=
=A0 =A0 When applying the linux patches to the current net-next tree (6.16)=
 the=0A=
=A0 =A0 patch 0001-can-dev-add-struct-data_bittiming_params-to-group-FD.pat=
ch=0A=
=A0 =A0 has to be omitted.=0A=
=0A=
=A0 =A0 The new features can be seen in the ip help text with=0A=
=A0 =A0 ip link set vcan0 type can help=0A=
=0A=
=A0 =A0 (..)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 [ xbitrate BITRATE [ xsample-point SAMPLE-POINT] ] =
|=0A=
=A0 =A0 =A0 =A0 =A0 =A0 [ xtq TQ xprop-seg PROP_SEG xphase-seg1 PHASE-SEG1=
=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 xphase-seg2 PHASE-SEG2 [ xsjw SJW ] ]=0A=
=A0 =A0 =A0 =A0 =A0 =A0 [ xtdcv TDCV xtdco TDCO xtdcf TDCF ]=0A=
=A0 =A0 =A0 =A0 =A0 =A0 [ pwmo PWMO pwml PWML pwms PWMS ]=0A=
=A0 =A0 (..)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 [ xl { on | off } ]=0A=
=A0 =A0 =A0 =A0 =A0 =A0 [ xtdc-mode { auto | manual | off } ]=0A=
=A0 =A0 =A0 =A0 =A0 =A0 [ xlrrs { on | off } ]=0A=
=A0 =A0 =A0 =A0 =A0 =A0 [ xltrx { on | off } ]=0A=
=A0 =A0 =A0 =A0 =A0 =A0 [ xlerrsig { on | off } ]=0A=
=A0 =A0 (..)=0A=
=0A=
=A0 =A0 TODO:=0A=
=0A=
=A0 =A0 - clean up patch descriptions=0A=
=A0 =A0 - maybe split patches=0A=
=A0 =A0 - add recently added features to dummyxl driver (e.g. PWM)=0A=
=A0 =A0 - set priv->can.clock.freq to the common value 160 MHz in dummyxl=
=0A=
=A0 =A0 - PWM rework/extension=0A=
=0A=
=A0 =A0 Currently the PWM setting is simply to pass the three values=0A=
=A0 =A0 pwmo/pwml/pwms to the CAN drivers data structure to be set into=0A=
=A0 =A0 the controllers registers. These values need some sanitizing.=0A=
=0A=
=A0 =A0 Additionally the PWM values can be calculated based on the CAN XL=
=0A=
=A0 =A0 bitrates. An new algorithm should be created to calculate PWM value=
s=0A=
=A0 =A0 when they are not provided from user space.=0A=
=0A=
Looking forward to the discussions.=0A=
=0A=
Best regards,=0A=
Oliver=0A=
=0A=
On 27.05.25 15:55, Marc Kleine-Budde wrote:=0A=
> Hello,=0A=
>=0A=
> Cc +=3D linux-can@vger.kernel.org=0A=
>=0A=
> On 27.05.2025 13:43:05, St=E9phane Grosjean wrote:=0A=
>>>> This is probably the point where we should switch the discussion to th=
e=0A=
>>>> Linux-CAN mailing list.=0A=
>>=0A=
>>> Yes, please do so.=0A=
>>=0A=
>> I don't find any reference to CAN_CTRLMODE_XL_ERR_SIGNAL in linux-can.vg=
er.kernel.org archive=0A=
>>=0A=
>> https://lore.kernel.org/linux-can/?q=3DCAN_CTRLMODE_XL_ERR=0A=
>>=0A=
>> how to talk about this symbol?=0A=
>=0A=
> Oliver, can you push your kernel patches from=0A=
> netlink-snapshot-2025-05-23.tar.gz as a git tree somewhere?=0A=
>=0A=
> regards,=0A=
> Marc=0A=
>=


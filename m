Return-Path: <linux-can+bounces-2319-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB7C9E349E
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 08:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA95816009D
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 07:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8061D4612;
	Wed,  4 Dec 2024 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PMNl34jN"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ABE1D47CE;
	Wed,  4 Dec 2024 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298565; cv=fail; b=oUMmVpcX8hR3Y16uzycp6mKT+TFWeaeHiNDe67hwnzcVcfO2e1Bg+xpz14KHbHmwUYXL4GCqrNiscBHy1l9FqH5u3ymhaTaIhWP6O8Kgi3Ii/nc46+xHTVzJBUthEbBVWyd2mE9aFgTJMMsDU1022kIqKrZlIAt9wpBIuvNrP60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298565; c=relaxed/simple;
	bh=effikDis1puXumgaNiicY+bwuwQW4y+vwQJbe/KXjB0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=vBF3tHAOaRjgJAKp5a5Fj14/pgtnxyB8cic+010GL9jo5r4NxTaelGDAzpwYn8A7GvGW98s/b/4FOGw0eUVQQX+KoK1mOjpLXdRuabOxP752gjKitQ3tnX9dCmS3zf/UDowBvHT4Eco2KICgD1wyZrQm8L+O+iw3kqX+CFSrzd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PMNl34jN; arc=fail smtp.client-ip=40.107.104.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ib1y3hzZSF4Tht4opQqORocJ+VoYcux5DG3jYgn1FldIFgi60DNxbJW/dPRF1iIbWE7B0Ds/pM12cDzxGUkQYzhnpHbYqsBe0CIZN5vc4LTfSo/mTc4g/OYyNOC+8YdJJD24Qoj8fksYfcRPNZZspCBBHs82mz2UbUCZyx0F0RF+hgkqLiLj5jX8SecGKCgl47vPjoVZi7gXEcl/IskjxxcLw7O5pGv3lPNTadBpSNo9KaM6Ohto+TTEOLB845xCHzSnJFiNaMQ7hHjpbonDmHugcWako6jOXZNZnVK52scmyYev1Lwv0MT5K0isoSNgCibgneG7rJxe0nnOoUAxZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd7eyrW6paO5m3DjOBya/f3hTzTxyhWGtIDUBgc9h6s=;
 b=Uyep5WBgHQakFzMTj8Rr6JuAkCML3HSjNmPhm8Cx7/R5STIRB7bCDx56Ky3Fol6EBMK8puivFPfWhEuUghr+lRixZEzZ5Tok8HtTjk/1XU3D7h1x3686aYzJdHlFjl//9ARO/6d5TNjnz7kWn7I70y+maTF0l0lhTOJwCtnuvoOwo/Br2RBvQLrd+eOhetRxv9BTks/iYm7FNKRLsz4eUz2AtfGYGmlbmNIus0Gc6KZJPhapHMJFvt+vXHNfYE5zJJnIHRpWZRf7r3BwqqTYu2QkUKy6Y/q8YSR4d94cHt52YoO7izIamlo2hu+CmUzp3+3H1UW9952UjO6417ccpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd7eyrW6paO5m3DjOBya/f3hTzTxyhWGtIDUBgc9h6s=;
 b=PMNl34jNV4qJvmMC1rfa4//JQ7NCSWd8g63sj0qBXSqXn+WfBda5TKGSYgRHrEgGbcc+yv2oe7FZNymNVtpjN3juUrmOrGcxCDZ3lRDl/sdvnggCKEFNiFcXzzViZwrrh7AhC2xNgwXB+/Q58wzvShNVBXT1dNAS08CuIkRBWswpfrNpP2MGtSexrnuadBmQdU+NoxnlYNnk+Wu7dQFNPBpW5RY4CkNgnGFsMihoPo3EaVL2ywWLlWEU0gnnxW22bgrsS3uv8JTE1sGyDpS25O0MHSHZ7QQcfL/Uw6PvyTJ9h3V7KyEBI1TBe5lJ4p/I/cwBMGYIuIwF7gq7XnNXSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DU4PR04MB10598.eurprd04.prod.outlook.com (2603:10a6:10:580::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.10; Wed, 4 Dec
 2024 07:49:19 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 07:49:19 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux <s32@nxp.com>,
	imx@lists.linux.dev,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v4 0/3] add FlexCAN support for S32G2/S32G3 SoCs
Date: Wed,  4 Dec 2024 09:49:12 +0200
Message-ID: <20241204074916.880466-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::16) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DU4PR04MB10598:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c1527e-d742-455e-4f11-08dd143828cd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tm1kTm9ibyt3WW9xK1pWR1ZaOVdLdHNTaGp3SW8yNGZQdFpLRFFyQmhNWGox?=
 =?utf-8?B?b09vanlIU1B1cVUrVkhkUjlVSXQ1MTkwYmhUUGw1bWV6Tk9RbmlVYmxpL1Az?=
 =?utf-8?B?SkJZMmtlME5MaGRJVU8xZ25GRWJ5b1MvUFNSWXNweXdHaTNRWnh0MWtJbk1N?=
 =?utf-8?B?L2Jxc1RvSFJDTnd2Q1lYV2FEVHRtazY1a0VWOVVzMHdQQy9tLzAxTlAyWVJD?=
 =?utf-8?B?cXlvRThzMTRkTUJ3cDgxQ3NmajlZODBRblZCbEZyVDNOQ1VrVllMM0lCNE9Y?=
 =?utf-8?B?WlR2enhOUXptQXZwYTMzMERWWDZHSmRxSjhYcE53U3cvT2pTbWJNQWlvN0hG?=
 =?utf-8?B?Wm9tYVptSzE2ZGFndUZkRHI0bFIwNGdITTRjKzVhcVgxMWFHRTNMV2EvamdD?=
 =?utf-8?B?YXhBTE45UUlUODNXK0xzcExvd2ZiVkhIb0lFNFFtSjZIVm5LbWx3QW1RZnlq?=
 =?utf-8?B?SFhhaUdTVStPSXRRaTBvQVRoRkh0NWwrLy9laWxXWmdhMnMxaTlWV2JPQXFr?=
 =?utf-8?B?SVhaMVNlMHpVYWQzR0QyNEFQY0crZE9YMFNJTTVMUG1TZFNMdzFBTWNaNno4?=
 =?utf-8?B?MjA4YW0zWHNzc2d1YUQwSU5JaG1SRjY3N3FGUW5HTHFRN2ZEcldsTTFuTXVl?=
 =?utf-8?B?dzdUTzZnWnlsYlRGeUlvbVA3dU1ZQ3BIUmpBZ1hkb0ZRNGNOUW9RcDNIaEdQ?=
 =?utf-8?B?REdGQi94QzdpSlJSTkxWbEkxTUdmMjRlVTVEZGwwNWdYVWxtQ3hWM2pqaTRh?=
 =?utf-8?B?SDJ0MFZzK0lLdXFXNHdIdHJVVnBBbVhyT3c2WTMzY0hVWHF5aHpOcmREcXo3?=
 =?utf-8?B?RkdkZWpnOEMvMGxPZW5PYVZ4QzNqM2Jvd3ZoYWxZQ2JDM1BwemhIZUpkTFR1?=
 =?utf-8?B?aFVPVTdsNmZia3pFeURHVHlJcHdET3hJOS9vN2dyZnJrODVOK2x6b0Zud1ZH?=
 =?utf-8?B?K3JtWTRtMDRaTCt6N041NVdKT2R5Y1J4Nkg5cm51R2JqMmF0UHdQa1FobWJl?=
 =?utf-8?B?bE9hdXhBVWV4elRyaHBvRW9WSnZ3Z1lDc2IvS2lnUDhNdzh5cXBzUnJsY1g2?=
 =?utf-8?B?VEVjZkxPTldGTnBNb1FaUW9IOW1jVkxtRUYrVi8zVjdxaWg2dC8vVXZCZ3Iw?=
 =?utf-8?B?NDdmZFY3bHlxM0xvOWxUV1F1NExFS0F4cGxweWcxeTJvZmE4NGkvZkpxbUdC?=
 =?utf-8?B?bUtRRDJvK1U4VUhIMVhMamI1S3RIVjVXNUJFcUx2dUxYa2puY05uMUtFNkRK?=
 =?utf-8?B?a2NGakJvM2d4bGw2aUFacGV6K3lpL2ZqRVFqVjBoNk5RWGNNeVVBZ3JRZkxk?=
 =?utf-8?B?UkREdU1rWnVVVlo5eGVWT2RPbCtWUTArK2MrOXhadWNhT2YrcDYrUktDU2da?=
 =?utf-8?B?VzhyQ0FKcEhNcFJTYWh0VlRoaVkvMUNqREtJem1VcHQ0RTc0bnh6RVFUcTdZ?=
 =?utf-8?B?U0JtdDN1TFk1U0ZYbVBTZDd1ZmpZWk9aVnpvUUg5ZGkxZStQbndhSm83RGRo?=
 =?utf-8?B?c2tmcUUxWm1aVlg2VlQvS2dTa0p6TGthWFlvZ1RzWXJraVdINm1OMkR0bDll?=
 =?utf-8?B?TU9pcFJpaTZXR2xreG5DaUR0eVNTRC94eEdSaGVMam9nVkgrc085QkNXd044?=
 =?utf-8?B?L1p6VUZwUFc0dzRyaGpmbHVaQ2x5MnViZHdnZ1NTdTFKUmJ4RzhoVjdCNlps?=
 =?utf-8?B?bXphV3ErSmh5dlFMaHJxcjlYcWFMSjJpeGhJVjY3aFh4L3BZSkhDcVBIUHZN?=
 =?utf-8?B?M2E3aVRqb2hUbWlselRDdkRaNW5KeC93QktycmpaQzRRcHcrTHpycWlyMnJY?=
 =?utf-8?B?OEtMUlNVbm8xRm5PY1VXdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFQxU09uS0Q0MUkrdllXK3VYbHBtYlRmSzNUK2FObWxDaGpBUWhBcGd0QkQ4?=
 =?utf-8?B?eWVjR1d3UzVEVmcvS2hiQUJYRVZqZ2VibzkwZGxmM1dpbVFzZVhWTkJPSDVI?=
 =?utf-8?B?aXp2Um1JZkQwTGtheU45L2ZXNHZiam1NYWh6SUNDbDNuWkEyV1kraldWK3Qy?=
 =?utf-8?B?NEI2TVlXZ3Z3OFJxZXZydm9FZU9DWGJhckpXa2hiWmdtNHhXaTBZMDh4eWpa?=
 =?utf-8?B?MDJDVGNIcTNXa3ora0wrY3FGbjNPYmx3YzVySjhnTVl6N1dEV2E1TEROZ2du?=
 =?utf-8?B?VGZqcWQzeUxwZWZGeDdJZ3c4bUxKNFdGdk5sVnB0Qmh1UXRXU2FoTEd6ZERO?=
 =?utf-8?B?RFFwNFRKcmtza04xd3lKeUlPUUZKNFdIRlNLNk83M25HRzl3NjdERWdIYWNO?=
 =?utf-8?B?OTJ6U0dpZlBzN0NhdlppSGtVT1JKc0pvR0NZYWtxM05xZmZ4ZnBuSnpuNHg0?=
 =?utf-8?B?Mmd3ZlZXWXkzeU0yNkszTm1lNlVyY1RMV09QUzNjbEUyNkF0cStGUjRaeFNU?=
 =?utf-8?B?eEk4bXp3bWJ2MGhNNlZFSmV2cFkxSEdjMXpsVVNQYzR2V2RaY1NuUjlXcUFP?=
 =?utf-8?B?UFYyRDBLQm5kbFFVbEhFWXRvS0V2QndjLzkvWUVPc2tmWHFoWlhGb1BFL09Q?=
 =?utf-8?B?WlEydnVtUFJqSTh3ZnpUaGFJUCtGN0NnUmxGZ3lwZTBEZVN1YngxUTh2QUhH?=
 =?utf-8?B?QkRpY0VDN2xKQzRhb3c4VlVQSkFrWEExVVFlcVB3UWRseHpMTVdBVUVPMWpE?=
 =?utf-8?B?QjJhaDViVlRBZ2pRVkxsQmtpbWtFSDdzaU1CTDY5ckJ2RjRreHpvY3VHWHVt?=
 =?utf-8?B?YjUrSEdlcWYvOWxZN2J6djFZek55UXM0RVdzN01uSFh0OTc0eTNwSzZsck4v?=
 =?utf-8?B?K0tOSU52UkdJb2hXNGVDK3JuZENaUTg2RWRyZVNPbm1QZmhKQUNIM011Nng2?=
 =?utf-8?B?bW5tUlVoMUdVUGVCa2Z0RFNOTzRxVXR3S3pIODg4MUx2Tkk2RUdNQVk2VTdS?=
 =?utf-8?B?T3FFYm1jU2s2T2lueXdkQjFHZDR4NGdLSUdCNXp3czVFcGI2TGIzbS9kZUNs?=
 =?utf-8?B?TU9GTXRFQjI2VjFHVW16QUwvZUowUU4xQ2ZHdm9XMWtrZU9ZS3FXbVpuZTJl?=
 =?utf-8?B?dnRPUUl0eVZZSjNPY3lJQVZCejRRbS9GV1BSelBPRU1ma3QzeitNNFc4d3B5?=
 =?utf-8?B?SGNzdlZWSlNuTmhvcnVEeVIwSzdTRnBlZlZQbGdvZTQ2V0ZRWHowdUFqSnhF?=
 =?utf-8?B?OFBVL3oxUTVrNzBoRVdhQlJMWFZkMFhHUHYzNUN6djZzOWdMYldJOE92emsz?=
 =?utf-8?B?QUZnU2tQUVBicU5aMUtFNHNJcEpURU91bmtRa3dZWkp5Y1owbXdHT3RiaDlZ?=
 =?utf-8?B?ZTdvTmVhbnUrSXE4bWFmblcvcXV6N2dKYU5HbU12ZWkxbzdXTVcxalgvQnFV?=
 =?utf-8?B?T2MyVzZWL2I2TVB6blBxQzdrWGp5TlVXK3BmVFY4LzMvbjFuNHF4SVRrVERQ?=
 =?utf-8?B?KzJqNnpQQ0N6eFBtelZtcmtCTmsrWlMxM0QrTmhrQU1XbEtSU285Y3NZckEv?=
 =?utf-8?B?aXhKcFhraGpkL3FGUmVoSHZlcUh6cnVzVS9nNHROb1ozVkszSkludkFmVDFP?=
 =?utf-8?B?RDR4TWFiajFwZks0U3FUSi93S2s0SGNmOU53djUvKzRHWVpSK3hqZDlxRkVI?=
 =?utf-8?B?dnFKaXAxSFhDdjNwM2QyRVJQZlNCWlhqM1pqNmVCOUpBUjNONVovSEZiKzQy?=
 =?utf-8?B?QUNzbXFvNUpOTHhja0lHdVNtMU1Gd0QrVk9tT3dqemVJZ2FqNjg0a3VsNERi?=
 =?utf-8?B?anJySkRqV0w5Y0VoaVJwWWt6T0l4Y0V3YkZJOG1qUG9RN21tOE9uUU00ckk3?=
 =?utf-8?B?OTVXeXRVTWhXZGcrTWM5SVducnBKYlNDZnBkbUtSdXYwcHIwbjN1bS9wWXVv?=
 =?utf-8?B?Zy9yaHVzM2NHMlZRZ0ZJSEUxcndZZUxkdmFIdXdrK092VXoyRkluWXoyQTlL?=
 =?utf-8?B?SmxGQ09FUnk1bVhYN2VYNVVQTWZaL1I3VDRldTFNS2F3d014YTRJUzhVK096?=
 =?utf-8?B?MGN6ZHAzTmRPYkc1eExqazd1Mk14cDhxbkZzU0NYeDJBc3U1eWhBOWVoek9a?=
 =?utf-8?B?bnZxRGhyYW1TQkVjVXpJRlVsZjBUcWg2VEF3WDdKeUNvU1NDQW1iZnBZeDc5?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c1527e-d742-455e-4f11-08dd143828cd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 07:49:19.4472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Nm+obAF1cC5wHMMVUxV6n1JPKMA1F2VhxUDESL6jA1/RkpA++0QjBMB/oiprKaX78jtEUzlu6zsLhfLQViGWlEK1hW8H289Lvo9yPwD/QM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10598

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

S32G2 and S32G3 SoCs share the FlexCAN module with i.MX SoCs, with some
hardware integration particularities.

Main difference covered by this patchset relates to interrupt management.
On S32G2/S32G3 SoC, there are separate interrupts for state change, bus
errors, MBs 0-7 and MBs 8-127 respectively.

Changes in V4:
- Updated irq description in bindings documentation
- Fixed some small issues with the proposed changes in the flexcan
  binding documentation

Changes in V3:
- Added Vincent Mailhol's Reviewed-by tag on the second patch
- Changed to 'platform_get_irq_byname' for second range of mailboxes
- Made several rephasing in bindings doc
- Removed Frank Li's Reviewed-by tags since changes were made afterwards.

Changes in V2:
- Separated 'FLEXCAN_QUIRK_NR_IRQ_3' quirk addition from S32G SoC Flexcan
  support.
- Provided more information in dt-bindings documentation with respect to
  FlexCAN module integration on S32G SoCs.
- Fixed and irq resource freeing management issue.

Ciprian Marian Costea (3):
  dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC support
  can: flexcan: Add quirk to handle separate interrupt lines for
    mailboxes
  can: flexcan: add NXP S32G2/S32G3 SoC support

 .../bindings/net/can/fsl,flexcan.yaml         | 44 +++++++++++++++++--
 drivers/net/can/flexcan/flexcan-core.c        | 35 ++++++++++++++-
 drivers/net/can/flexcan/flexcan.h             |  5 +++
 3 files changed, 79 insertions(+), 5 deletions(-)

-- 
2.45.2



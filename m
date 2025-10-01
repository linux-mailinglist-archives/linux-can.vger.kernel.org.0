Return-Path: <linux-can+bounces-5086-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A426BB07EC
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 15:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA743A6A06
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 13:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2598A2F39DA;
	Wed,  1 Oct 2025 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lMiPtn8Q"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013060.outbound.protection.outlook.com [52.101.72.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E7E2EF670;
	Wed,  1 Oct 2025 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759325013; cv=fail; b=pSTsfH2fueTxIFBNhoEWrAvxHzpsbCIEahsUuUUzntT3z82nldmEsCyW89FuR+kimdm47hSYKaeU+67d6ZgCx3p/AaKcWqZbUrKUt0fjxZ5X7kBK1M1pxhgqSzRUKjhZiALtuU3KL7T93FZaX9fjIdrG1WV3BpUGllMNvHBkY7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759325013; c=relaxed/simple;
	bh=gCIkVJ5687w4JC/iXH2zdfPKdy1y9n7kFucnRZ0EZx0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=p9A4k/cBMw2kA7VNTL3VtsgSwAE91TT0fj5fDXeHLnWw7gneWZqsjuW5S/dyFTgjTWU2N4EV+aM9ydMAWoTZma3+iYohEkoCcs75a2xkd/NxAssvRWH/Um0b3iPez4eVv3LoFHYzi2mHM0LbY7uFTQWyD4SoITiPkIyfweC2VG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lMiPtn8Q; arc=fail smtp.client-ip=52.101.72.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1cE86Wj+l1t3gr00OoCUgJ1Qwn7GStX8WR/I2JmVtoQbHNnCqsUKzW9LRJEPlvhE6Xz3QRFZFbUnVHycXnmlBFZg9Si8khhCDVwz7hQ0K9clkQJHeKW01FZ3uYtWr5PyEHfPWbtNNUClplJK/7NPE8PL/7cnCzSmagOetDobz9w2WF+M7ShNReYbv8agQ6RGa5mTOUShtEKM3snfP2ogXp4VV/sM9jLpy8qBFAjyICdnwSIGAa8DGMB2X3pRbjwoDzL1Fmw0TAH0/ac7iUbXlwpmgpmmru7qCcap4JFXnvOBYO3+zcq7pgJtcSuGZYhBhMMwOuVtT/yTHQU2bURbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4LrV5039zmXiZB4R2+yiz3v81A0BrqjClljoXVA8DA=;
 b=yN8uAMtuDX5ulXZn4Htf2e5HYNACntV70gPv9O3OTowX/TdKRViigejGc8l+3mxPhEeKtY4jk06gTsKWwjky2iMmtyD5MCUBVSVP4Ksa2PXjdsuieedWo6DLGJjUBKW1N3F6ZjJbqUGs9AFUVcHqRU8NAj7Dw/J7tkwhi3Kaj7rlwgU28sNWmIu2UFfK2dqo9NKMgyJiGzrh8LRHh1Ux5VslLBZXfepuH4RMjcM5SSHSfRXHKU1KPyPVs53DHr4UBDqk+LGQoHrZyHCMkdc3l4L+5II1+q+4/+9UxoDadzcxxA72RvNs5GG8PgdwauLtIm/sk6a+wpYbbL8l7cdMkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4LrV5039zmXiZB4R2+yiz3v81A0BrqjClljoXVA8DA=;
 b=lMiPtn8QN4p+wJoiocpvbcLYDZpsckum0LAgBO08xQFxEB5rcKLjL5zSc84l4+5R2f26H0cQ5CiZ8jJ3RHYj/kMCx8yuMaCODgPhecPDxaaJAMpPZvCvpGLYGa2I6z3gBTA2bZkmEAuxWvVv6sA7i/sEL3cMh9en4PyCWBGJJk6D4zwSTEVkJU5a9NN/G76lvM+RTpveyRQjwFFYEHf3pwlieizZi1ozMhN2uMiRdpeWGuifmAU2i7I50yKyoHlcqT3QPe0UWd9WrBQYZjt1o6uOgNprXbXEh8xYyKaW6+ACZkx+b3kviG9/4tuBz7buWl0DA5Z601O6j11HuVAszQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7227.eurprd04.prod.outlook.com (2603:10a6:102:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Wed, 1 Oct
 2025 13:23:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9182.013; Wed, 1 Oct 2025
 13:23:29 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Wed, 01 Oct 2025 21:22:37 +0800
Subject: [PATCH v7 6/8] arm64: dts: imx95-15x15-evk: Use phys to replace
 xceiver-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-can-v7-6-fad29efc3884@nxp.com>
References: <20251001-can-v7-0-fad29efc3884@nxp.com>
In-Reply-To: <20251001-can-v7-0-fad29efc3884@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759324965; l=1466;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=gCIkVJ5687w4JC/iXH2zdfPKdy1y9n7kFucnRZ0EZx0=;
 b=vYHkwshI2qtCyJAXwedu28OlVgALOop+HQXC7cFpznX/oBtXzNygj/BJija2MKWn5ALGFhwLc
 neixQEmgywRAyiCiosx2+u7L8o9PIK/mo5UGVeMDM4OnD/TB00+Bjez
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PR3PR04MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4fef01-877a-439f-3394-08de00edb622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|19092799006|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXZkS0pYN1hXQUNzQ002QjkxVmNvZzhmTzJ6ZGRCVVVvN2RGM01IT0U1RjZZ?=
 =?utf-8?B?S3J6NEdpSFVSeXNibElrSG8rb3NkR0MxcGZOczlUcGFpeUxYblZqWGVsRWpl?=
 =?utf-8?B?RkhiS2RpLzNUeTdkNHQ1ZTlBTWtqb3RYMWdzcG1GYlVBbjdKUW9DR3BFT1RN?=
 =?utf-8?B?Qi9INzNtbi9BWmZvdHFsUzl1Q3Z3amxTSXFEaDFUMC8yNFlpbG5VM0EvRmJn?=
 =?utf-8?B?ajdTdEs2ajdPM3BuZE03dW5zRlBTM1NvOVFnbndEWHdQZGlrcit6TWNDOG1j?=
 =?utf-8?B?eHBIMHNzK0lwbk10NXV3RkNDR0IzNE5nayswaWxCQnNIS1VSYUdpZ2hDblBJ?=
 =?utf-8?B?VE5OTnVhNzlEbDR6WXNLRlZIZ2c4M3BUdC82S0F4d3dvNjA0Y0t2ZDk2Ykll?=
 =?utf-8?B?SHY1ZjN3NEhGTkFvV1pSZDFxNDV4ZTlraVZ0SEhTWEt1Z2p4bEJnRFBMdHYx?=
 =?utf-8?B?a0tYMFlUQ01SL1hKNHAxS3RmVmIrRG1MUkVrNlBMc2R2Ti96NlFQVmpUYy9C?=
 =?utf-8?B?ejYrdytIWkpkd0JDVzlUdmNGM2dJS3JMbGtrdXRFTVNmWTl4MDY5N2tIU2ND?=
 =?utf-8?B?VlNKQTZSUkJNRVZyZFNqaCtKbnlLckFkcUFFUW1RbnlYWm1nc2NVM2lrVEI4?=
 =?utf-8?B?aG9pbmRUemRmZFlKZXJCcEltVnhhcDI5blp0dm5SQWRjNkFRZFhJWVNMblNV?=
 =?utf-8?B?amtLRWlYaGtCVW1kaEtSZFVHSzEwZDQxWjdPY3N0WmlNQjJvZG1Na2JDY3oy?=
 =?utf-8?B?ZmN2VDBwWlRZa3RhdGxTRU1JVTY3UzV4Q2RLSHlQT1laVDF0S1luS1plc3pi?=
 =?utf-8?B?UlFyL1QrTDNKSHpsa05TMEI5SFlXOWRUbjVIdkxDL0hBeGdjZVlQRDVSTndn?=
 =?utf-8?B?TlJNUTIwMkFiM1lsMXdjRUN2UmM4TzljZmhXZVJZRlRIbHdSUTFVZHd3OEJS?=
 =?utf-8?B?UGpNNFFxSUp4V09BNGh6dzdWVW5obUMva3FOVlpPanA3QmxKYnUxWDFScDI4?=
 =?utf-8?B?OXI1cncrMmxHUTA2YWNtZ1F0R2RVdWlsRFhmTlRPOWZ2Mk1RRE1kUVFyd3dp?=
 =?utf-8?B?YVpRM2lBdnpyYTB5YnQwRGRQeDg0Y21ERkdYYTRCKzFBRCsxRUlNWHlYMGVt?=
 =?utf-8?B?TVI2Y3dhZGxQR2wzTXZrMW0vRm5hT2x0eWhwaEs3MTRoekFFcWdkczNjcFcw?=
 =?utf-8?B?eFA3bDZvTVJTUGNFZHJoQW1sM0FrVlBGOU5SV2NrbTVQZVlNajFFeWcwbGF3?=
 =?utf-8?B?cUZGQlp3bGd4dkVsZGtsMWV6a0JSMW1SL0VHUmxFYVgyTWV2dHFpNnJDeCts?=
 =?utf-8?B?MTFDR1pseUxQNFpGOU53eEFnbjdqZnphMnNOMk5uMGZETFRtWmVCVStRdEQ1?=
 =?utf-8?B?eDNzUGJTZGtzdTZXL3VnWlYxR1VYaUhsTm5FdUlvV1VwMEU1Zi90dTFjcW16?=
 =?utf-8?B?RXVjblFNZDJGa0szMStqQ2UxSm5yZkdWVUx1cTBZcFBRYVMrdXUvYTEyMEpm?=
 =?utf-8?B?VEl6dEdMTjE3SXkxbCs5RmlPaEExeldLOXVzREpIekVIbEowdmxYbG9JRnQ0?=
 =?utf-8?B?bittR3ZiZ0xhMStZRVJtajJMaEZDWjNPeDJkUVp2RG5jaWhvZ0hybXIvMlNC?=
 =?utf-8?B?RFpmdmR5am1vMHNtN3N6b2VyV1o3dU8wdnRpRWJsZHZjN2VjVVAvWG9nbnc5?=
 =?utf-8?B?YU1Na3B6M1IxWW5KR0ZIWUZxQnAySXJkY2U1RkIzUVVPbVc1RTljRW9wd0hv?=
 =?utf-8?B?czU1Z2FySlZ2eU94WitMUW9iUWdPR2M0dVdaeHRMOUVQMm5WYytCOHQzV2hR?=
 =?utf-8?B?ZkNvUHgrS1pjQjIxcFBJb20vUDQrYmUyY0NHSjdPT0QvTEFjZVI4d0JIZXhX?=
 =?utf-8?B?eFFzYzYrWHNPcktWSXY2OFRDdnFmb3JodXJOWG82WkUvbEppY1U0K001dzlR?=
 =?utf-8?B?U0VVeERxZXpaQ1NSMlBrWDNOdm5QQjQ2ei9WUTRDMUhTaUYxRGN1V1g0YjVs?=
 =?utf-8?B?WFJxdm1MYTc0SjJUd3RrMWp5ODc0YjA1dStJb0YwanVBQVVTeERhVzhBbU9X?=
 =?utf-8?B?eml3V2M0Z0d1Zlh6N1Z2b2xCdWdlZ011Q21KUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(19092799006)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bE5mVkNkMjJpWEg5ZWNvd0pyaEZhNEwvTHJqQnI5cTZZK08wRE5WNEM2dk1Z?=
 =?utf-8?B?OW12WllRaGdWQm5xYWFJcWNmSFVzQm9BOHBXb0lZdjNaMzFuTlpSRnEvQlNi?=
 =?utf-8?B?WTd5RjVGOHpXSlpvR2orN0I1dWh6c3o3ZGdrRGlKUzN5QWY0cHF1amxrVG9k?=
 =?utf-8?B?S3d5NTRLU1VvejRDQkh5YUlBcjg4R3VqaHdEaEs4RkFvZUl5ZWJwdlM3OXZF?=
 =?utf-8?B?a0hBNThCS2hoeXh1ZEltc2g4cEsyZmZHMzQ5ZlZmdW96Ymc0V2UyZjN2MFdK?=
 =?utf-8?B?V3pNci9QZ2c5aUpvWmJBd0xJN1RSeFkyRTcrKzhUWHRBSEoxSURYcUFxTk5D?=
 =?utf-8?B?V21GSmExV0RVbjN1UXY4clhqcENvOTkrN05TQ1FWeEY4dGpucEcra0thMHlT?=
 =?utf-8?B?WFlWSUltTTk1NVgxVTZ2VWZhK0c4SVlyQVhWcFp1S0trR2VJNkd4RW0vTGdu?=
 =?utf-8?B?VmxYVGRIcEJtK3NFa0xWdm1TbWxqK3k3SkpCdWpXWCs2WVd1TmxXTDREMFRp?=
 =?utf-8?B?RGNZSWJOOU95K1J5RTJGekgxTFpRYmhoM2lXUEI1SEcyWC8rdGU5U09CYjZj?=
 =?utf-8?B?WnAzcnM4VUYySUhrOTFsUUQwQTBYaWhvTjFLbUM3QjN2ZHdRQVRpQ0I3UzM1?=
 =?utf-8?B?aDFEWm0wSzVkYTBybWxuK3gxQS82R3hTcldSYzk3elp2ZGhYKy9oSVdzbFBB?=
 =?utf-8?B?OGI1K05mREhVYW1IWFZyeVp3UnFmWEZTdlNvdTVLQXJPV0FDOUtQbDBiRTVi?=
 =?utf-8?B?aVdvemc3dzMyNDRPV0s4SkVCcWtYMWpRaGxIUzN5dUVrNFMyMTk4TmlBTnJ0?=
 =?utf-8?B?aTlCR1RRQkhZcWJIQUZ1Tjkvbis3dWZxcS9zVTJMRzRQaTByNkRoZTVxMUl2?=
 =?utf-8?B?dk5Zd1VueGNuU2tIc05aS3BUcDlEcHRlQ0tGYzFvWTRFeVFsOHNtaEZ6Ukcr?=
 =?utf-8?B?VFc3bXpCNlhaZE4wNDVTc0xBeExpS1RBZGtCRVFBR3h6NlQrd2R1UTZQbzNT?=
 =?utf-8?B?L3d4eHNEWDhnSllUZGpYUXE4WC9pVWlOOVRoTXB2UmppZXlHZGticlc3UEE4?=
 =?utf-8?B?WEgzZVA0aHNDcUd6OWM1RHdrWjBzUW5HMlNpclpuYVZFcW1rSnJ3NU9FTFAv?=
 =?utf-8?B?ZVY2b1JKc2c3THVJN1pXVHZoZW1KcmE1aklIU1lvWXppL056ZTlWdnRqak1s?=
 =?utf-8?B?OEhkK0JVRzUvY29uVmI0QmVwaml1clVsdFluSE1abU5tdWp6a3B2WmxSTkZz?=
 =?utf-8?B?WWlxRW85NmVPZFo1OW1tYlNQdEZ5Y2tjNXZOUDg5WTA3OC96b3BrZllWL0FB?=
 =?utf-8?B?TFFjMnR2OVpOaFhURVBzR3NaUHR2bWpYY0RVL1RvRlhXUDZLekFDTElqTkFk?=
 =?utf-8?B?T2lXMUE4WVFCZVJqRlB6czlIR1pHRUs5SDVid05NbDZqeExYMmRPMXZvSS9I?=
 =?utf-8?B?NUxFRVpVR1ZnbVBHVFF0NG8wR3JMR1NOZUI5VzZrZVpURTlmMU5nQTVaeFRC?=
 =?utf-8?B?UE5UeS9haFRQNTZ3c3B4cENIZXpsWnpxY016WDhFYXp1eHcxZURwWDVaZ0Y3?=
 =?utf-8?B?eXlKS1haL1NFY1hvd2luK1pMdXBjM3l2aUdFVkQxajJKSkZjSUVKV3BnTnlr?=
 =?utf-8?B?b3dQWnY3S0RlaUlOQWxaN08xREl1clQ3TjdOaXpnb3NrczZKOEpsemw1aXBC?=
 =?utf-8?B?NUZldHg5bVdJWXZLaWJtWW1tOW5OMlU3a3o1NjJzc2ZhdmFLMkhsUUgyVkxC?=
 =?utf-8?B?WTd1T0JKVkxzdmw1WGIvSEhMejZWL1F2WmREMFZxd2ZWRXJwZHV2WlAvRC9S?=
 =?utf-8?B?NzFxV0QzMkErdXkyL3piS2d2M3FPdVlzM3NwQmdJWWdEeFlBNXJ3cVJhcG1v?=
 =?utf-8?B?a1lFbi9OTzQ5c091ZkFoSXNsTWVLRXBKWnpqTGFiZ2phQjJDcERqVXc2Z0k1?=
 =?utf-8?B?WE5HOU9zRVIwV0xERUVVdHlOd09MenMrZ052L05Rd1RwQ0pGRWlZTXhsNUwv?=
 =?utf-8?B?QnFEbThRNlRQb1lOWUZ0a3RiR1lZV3pCTW0xMG10YUxSbkQ1TU5WRlJueDB4?=
 =?utf-8?B?WHFoR2VSQktJZlg4RG9id2xXSVRna0ovaXJ0cmF2U0pXZzE5SWRrN1hCZHl6?=
 =?utf-8?Q?bEAyYLpmM0J2ewFuoc7WwOs+T?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4fef01-877a-439f-3394-08de00edb622
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 13:23:29.7893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6TqWQYR6/BevpJg3lv84lYCT1TW0354SPXGxMuRr01ZssHqWItS5QZ1oNQTugcZWZUps+1/ZrTM+Osn6V80vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7227

The TJA1051T/3 used on i.MX95-15x15-EVK is actually high-speed CAN
transceiver, not a regulator supply. So use phys to reflect the truth.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index 148243470dd4ab03afdae949c8316f31467d1377..a15f021498869918945405cc7f34ea7e27ae6aea 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -106,12 +106,11 @@ reg_audio_switch1: regulator-audio-switch1 {
 		gpio = <&pcal6524 0 GPIO_ACTIVE_LOW>;
 	};
 
-	reg_can2_stby: regulator-can2-stby {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "can2-stby";
-		gpio = <&pcal6524 14 GPIO_ACTIVE_LOW>;
+	flexcan2_phy: can-phy {
+		compatible = "nxp,tja1051";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		silent-gpios = <&pcal6524 14 GPIO_ACTIVE_HIGH>;
 	};
 
 	reg_m2_pwr: regulator-m2-pwr {
@@ -317,7 +316,7 @@ &enetc_port1 {
 &flexcan2 {
 	pinctrl-0 = <&pinctrl_flexcan2>;
 	pinctrl-names = "default";
-	xceiver-supply = <&reg_can2_stby>;
+	phys = <&flexcan2_phy>;
 	status = "okay";
 };
 

-- 
2.37.1



Return-Path: <linux-can+bounces-2613-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEC9A0B8CA
	for <lists+linux-can@lfdr.de>; Mon, 13 Jan 2025 14:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D856916379F
	for <lists+linux-can@lfdr.de>; Mon, 13 Jan 2025 13:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECA5233D90;
	Mon, 13 Jan 2025 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RRZmvYBr"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A96F231CA4;
	Mon, 13 Jan 2025 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776431; cv=fail; b=iUWT2/ksro+C8XTFAUxFv5vZJ86O+a8+jQHfdjQSIWUmVHUHS6QIXAYkkeKKjCXvctvaZe6Nzx4c0KeCM2qe0Vb+pGsnaNsHPE+80Qc5TGNuxqrDU6lqWchUblDvNXpdoJ7PwDRMMNa8B4/7HrWUSglSV+Ypi56JOJBsrFqQkmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776431; c=relaxed/simple;
	bh=23ljOeK2UXuYNOfvlqXbdbbuq+xxgNWQ3tIgV4IGoEo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ATZZbWOZVNAjnuaJT32CcomG9GUh/HukDQuF+lErStW2/DQ6Xrq+5sl/8TOh1HUhrILNvWLBh3nu8yBMbtt/p6iraRrhbq69EobglZkqhp2GYGOMfKM7Fzr2QuEbmoDZfoXP6ZExJE4dSnmIFZlZsDhUOH7JUJ+l46FSSWF+078=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RRZmvYBr; arc=fail smtp.client-ip=40.107.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHKlNUJxHdxvPTCtcXGfFclZBy8YtiiVhU2Yz3F9QPpROk+ieO5avqQnwsu/4X8fSSywODJO1dHfoDpIcWuar4/jevWKSckr9N9Ulkwm+yk2Mc7X4KG1Xvg5arKBGgpgcs9oDOK9WEsz1fZdJhl8rxjeQXFITPPL9QZ53oCwYlF0fDusQ1/QBrERZLamMi0HxNPA6gSqcBRRC7bhTpz3vkZz57GVeRRfoPaLPzeeboWCQG6mgcxT19aSEqrEUEHewDmS81ylyaYyb51rx5YkUwz42L1Gl52IR6wfZjvQks1GAzq55kw0IonAgZLXY8y8igBrw8Z2SKV3kbCuhL0fbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlQ0qVNvrq27QAydP7QZxF2o0DJCySEIRYn5+EGPYyo=;
 b=cPopRGI+9lPnZ2/3NclQc4mem5poYZlBx8lxggW5fJ7YGCTxIJ+ufvQkJDCeORP3YHlSg3+2Tvjbmd9g0Ay/7LINBFaI68gCCA2E+egT+PzX+Wlpv8xNmrxqnudROtfnU64TxWrK0Sg0aG3ju6F6fpn365AIyGGVC4lznvQFGWol1FvRrOCThN7eoa/EsXxE0U6250mAjqJHt/IjqOlq08L3Fs2bP6PwL8cWcfsmIBYIZ8U90At5UEoqAOtJjJFOF7QJz5CTzuGPuyQBcpcmevp0ZTKJW+htdEQhOSZgl8bwv5eLQkTDQctX/FZN8MqaPjwteZwhg4mBJL8DT+FuzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlQ0qVNvrq27QAydP7QZxF2o0DJCySEIRYn5+EGPYyo=;
 b=RRZmvYBrlIlSPvzfhqsBp447vubzYvdN7xEanD9SJXOBfjd8tbLg8Kehyc6dTYRr/K/XeCVf6K3zaMtb1Wb2y8m1C5HDf1FzIzN+YfAkE1K9A+AeaVn6DD87nGpKt94v7G+/8SwF7nQ6yLfh/dzhmn9oPYbDtwQa3X/OPwrSd5sAWTXaAN8pECZ3H9tjJdPUTKxhHOMzz1C0hpBhYZkNsMIwJGpIrqQXUC7PrmQegb+F0phcHBdHmDZEnOqmPdMExPrXFhVGdj+AJ0a5c0+JPJWJ40muGM34bjn0tuN76gxMY3xrONnnkOd+DAK0jCetFtA/I478VmNdXCR60RB95A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM9PR04MB7650.eurprd04.prod.outlook.com (2603:10a6:20b:281::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 13:53:45 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 13:53:45 +0000
Message-ID: <12a50b88-58ea-4df4-9770-68b1ab720d94@oss.nxp.com>
Date: Mon, 13 Jan 2025 15:53:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3 RESEND] dt-bindings: can: fsl,flexcan: add
 S32G2/S32G3 SoC support
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-can@vger.kernel.org,
 Christophe Lizzi <clizzi@redhat.com>, imx@lists.linux.dev,
 Enric Balletbo <eballetb@redhat.com>, Conor Dooley <conor+dt@kernel.org>,
 NXP S32 Linux <s32@nxp.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Alberto Ruiz <aruizrui@redhat.com>
References: <20250113120704.522307-1-ciprianmarian.costea@oss.nxp.com>
 <20250113120704.522307-2-ciprianmarian.costea@oss.nxp.com>
 <173677598052.1702137.6360834668377737017.robh@kernel.org>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <173677598052.1702137.6360834668377737017.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0004.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::7) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM9PR04MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aabaee0-f0c1-4b3f-a5c3-08dd33d9b242
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2daT3o4eStEektJc1E3cUlIa25ZMDhWa2VKSndEYkZvYzRaMllVbWFQQUIz?=
 =?utf-8?B?VTFEeW9TK2J0YjBiUklaaXpIcWplUTlKQllmaTRsSlZXNDgvRlN5US8zemgx?=
 =?utf-8?B?eU5qNFFkL21JZGlvQWZhWXpKSHJyMzNzMHhTL0NEN2E3S0Z2eG1NQTZVZzNs?=
 =?utf-8?B?aE5RNEFPeUpuOFdqc0NmamtzOVdscEIzcWRETmJQMUllTVpSa2J3SDZNYlF1?=
 =?utf-8?B?ZzdUMjJFRGlrM0F6N1ZuWHN4YnFXN3RudFg5SXRhVzFQdWlGUVhGamRJenJ0?=
 =?utf-8?B?bTRLQThjbU1WVGpmMnIwVWpjdkI3ekxlQmJINk9FUXVGbDRZZmU3ekF3UlFN?=
 =?utf-8?B?UmtnNUJnaXNZemdFZWxHVFJRaDNWVSs2bWJUNDhteTRNKzQvNFRZS1pOSHR4?=
 =?utf-8?B?amRYRzMreWQvS2t2Sk1QL2xMaXlsOXNpUEdCU0V2ZXU5MnNTRVpTMFQyZi82?=
 =?utf-8?B?bDdGZGhYeXJ1Nmd0MnR3TUtDSklkY1BzQy8yQVJ5MXc0ZUZ2dEYrYUluN3RC?=
 =?utf-8?B?dXFvRFJ4dm9yRHk5NGVFZ01ubGpVZUw1MU1PK1k3SHVVWVEyRWw3R0ZEVVFl?=
 =?utf-8?B?Sk82YUpybW9lL0ZoVnoreHVoVDV2VDd2QTFvRTNQZ01jbmNNdERLQWxMSTNS?=
 =?utf-8?B?b21vc2djbGp0SjBxUTcyRjczajhMZ1hTTU9TenBHeDhhL0VFb0p2eVFZeERp?=
 =?utf-8?B?NW5xNWlnN282a0JlUmRXeTlqOUI5aFVBU3hWbHJiUXhyN2RZc2NuUUY0Tzlz?=
 =?utf-8?B?Q1F2NHR1Z1EvRjhhQ0YwTEJ6NUlqeTY4RTJWb1RVZUFwU0J1QXlnbzNXOUZ3?=
 =?utf-8?B?VXlVTFRMSTArZnp4UkVIRDBmT0FZQXJIdjdYak5LcU0wWlVmaGNsT1BMNStK?=
 =?utf-8?B?Rll6OUQyN2FjM1BDQy9XcmxGRWRlUXZEVndTMHBTdVpZZldMTlphZnprUWZV?=
 =?utf-8?B?TDhrL1Q4NUVPQldVcnNsd2VuUnpqamljZ2M1c3dwUWVaZGZOeWkrY3kreDJO?=
 =?utf-8?B?UVNhUTBCRzlsV1A5dzZFYXZBUXExcEtLazJDVUpoMUNSOUVseFY4cVpHK1Bw?=
 =?utf-8?B?L1A2TEFacitnb3VZbVVEbkF5bjd3dFo2cmNnZ0xWdXYwa2M1YWJoMm5VOERo?=
 =?utf-8?B?L25yMk9VZVVOR0pacyttdEdWbG51K1N1Q3VyVnBtcXJyMGF1VEhSMy9wLzZT?=
 =?utf-8?B?NlN4OVNrcHIzU25LSlY3b1ZtRmxMUUV6cE4wbGpoMTF4RzN0Y1UzemlLTjVx?=
 =?utf-8?B?TGxwSFJXcTNSL2FKenAxZ1dSTkdkVWpLRXNhbnlJdElEU3E1RWRRQkNkRUFh?=
 =?utf-8?B?dnZBMzM0WjVYK0hQYVhObXJCY0FnTitQamttc1dITS9YRmxqN2dQMkJHWjZo?=
 =?utf-8?B?cC9Ca0NJUURsTFBvR1pZdENJaGc0TmZIOWN6cStqRGQ5MVBVN2ljQ1Y4K3hp?=
 =?utf-8?B?WUFmYmdXV3RlejR2cmpjb21LVmMvQXh2RFBxWkROUlVJSFVkaXM0NVFDZFF3?=
 =?utf-8?B?Yk8ranFCV1Z5bTRLaGp4ck1MU3lhbFFURmNLRjVodUY1ajFwL25TajRVUWFY?=
 =?utf-8?B?MGZiMU1tYTZTNnJJSzJvRHNIazRqSEJ1K3dTYmlvRm5uVlFwQ292N1p1WnFz?=
 =?utf-8?B?UnpNM3BidTh4azloQ2hDZndMa0VTMEVSb0NwdEd4MDQvd3VIejM0dlRWaVgr?=
 =?utf-8?B?S05WT0RaT1VKV3lyOE16OXNYSXhDL3JYNkJaMXhYWFBvTHBWdzQ4ZFFtNnFk?=
 =?utf-8?B?bmFhSkJMOXNyUDJsc0htNGd5Sm9WUktTbkJ2Z1FOOXdQOUhENm9CUUdoaGRW?=
 =?utf-8?B?OGx1MDk2QU50amxyQ0tzdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NERTOHVFUlNSdGtxdlcwSldGK3VVcitsSjRFaVIwbFc0QXViSXEwUHFqNGs5?=
 =?utf-8?B?Wk4vUEd0RTZKWFZZOWh2YVphK0dwUHJZdFI4Z0s3aU5ETjdzWTRXaFpwZURT?=
 =?utf-8?B?WG5Ua0IzYSs5RTRhcWt6WFJiTUtOdGRLelo2Mk5sa1Bac3FqT1BvVnBYWXJj?=
 =?utf-8?B?VlpTdU44ckwrTUtPY3ZRY0phR01LY1NNSGVyaC9kYjMvL2ZPbFVoT3RhVVJm?=
 =?utf-8?B?ZDBRZjlWRlhyT1N5SnBpOWp3ZzVWaGVMUXhyaGRrWG02c2k5RllUbzRoWUph?=
 =?utf-8?B?cEFPQlcyTGJjV21ZUmdiNTRoQStYdDAwNlhBRDV1QTFvTVdRU1pxMkV0OUJs?=
 =?utf-8?B?aEhiKzdkTlRWcU9JMnplZFFsNHdmYldxUlgzNzFFakEvR2I5ZVlQbzZrM3Ju?=
 =?utf-8?B?UmRCNHhnN3pYSkRiRDJOYURjNk00WXNwTVRyK3I5V3JpWEJkeVFUeDlDNXEr?=
 =?utf-8?B?QVJYanNaOTc0VFFaTEFMS3Rjdm9iaGdYL3M0eC9kOXlHV0ZZNUx0WjRPNEpC?=
 =?utf-8?B?bHlIVGhscEFoWXhkYTluUVRXSDNpd0JxcXhQcTlxb08zMlBLME9CcWk2OHJQ?=
 =?utf-8?B?SG1NRHB3ZnRKbjg5bzBMOHdyUzQ4ZDliMloxT1hrRmEwOTlOTWFlWDZOVGRZ?=
 =?utf-8?B?bXZCWENBNzRCVG9mNlhHVy9ST1VvcE1IQU8zS1ZDYXhqTU1VZmVheXpLQ3lM?=
 =?utf-8?B?Y1g1L3JQd1F3U3hsQVhVUUxGbGoyTDdtYXJETWRUbDFxMHhrMU1vV1p4UGVZ?=
 =?utf-8?B?dXdXcndnNCtPdmVXRENmaUVISis1WFNORUZoMWNmT2o3eTBLRWZ5bVI4dk5B?=
 =?utf-8?B?cTdOTDJlMDRMbGNYNjZ4MXhUbkYxb0xnQjBCSWJRVzdMcnhrUDZzTS9NZkhE?=
 =?utf-8?B?L3FEdUd3YWV2WGNNOGVsckhpdVl5RitGR3I4YXdqdGxlWk5XajVuWkMySm4x?=
 =?utf-8?B?cDR5cVdzeXNVM1VzWVIzUUhzWldYZ2duYjRBZGV4cEhZNmN5MXJwT2V4Tzl0?=
 =?utf-8?B?Y0pKOFRkTmRPSFFuQjFkQk44OFZLREhiODRZckxiNzR1cmdXY1llSVdsbFpr?=
 =?utf-8?B?VGNXY3BKVTM4ejFKOG55UVZybkFQVm5CUDZWVXJheXl5MU9LTDVFUHBpaDRC?=
 =?utf-8?B?RnpqYld2VktGcTAzS2p0dmlMdWszeFNjNi8wMjE0ZEJqaXl3TWNtYitTMVpj?=
 =?utf-8?B?WWJuVWZ4US96UzlRNXl3VDVlck1CdnBrQkUyUGJ1UXk4R3B3b0xUMDdoMFRR?=
 =?utf-8?B?UmRnbDg4SlU4NFpZVmV3MGdtamtqTlNlYXowUXBaVy95eFM4TDZ3SktMWTIw?=
 =?utf-8?B?TGV2SUc2VXhML0xleUxZOE9ncTdYTGpQZ1kyZWFUeHpmWVJBQ0NyTmdZQkd3?=
 =?utf-8?B?cDBzRUdlTWRUTy9ZSWlsQmt6VkZ1dTB4SmxvNDQ0OW03YkpDSklhMHF0T2Ny?=
 =?utf-8?B?dmh2T2RheC9hek0rYjFqeW10NUQxR05GTFN3VmRRcExONWxMbVRncjFYb3Y2?=
 =?utf-8?B?Y3QrdEQ0c3NMVE9TSk9MNXdMWlkvaWxDamdFVWRTL3JUcFBPUjBMWXdKL1c4?=
 =?utf-8?B?QjliSit5a2NkNXFZMmtQRlR3YnAxRnpnUjlnT2tYeFphMkRMYUFpbjZXbDJm?=
 =?utf-8?B?NGI1MFNjYWIzblNISmtMVlhWRFJONTd3Wmkxbnhyd0xlSlh5SkFaQXNSZDJo?=
 =?utf-8?B?TnNHbW5zcTVYdi9LM2FMaVlOeDZXSlhtdHF4T2tVcFJZYVlEU3RIUFNjTzlm?=
 =?utf-8?B?OHJlOEFJVlptRUFGb0x5SlZMd0l1MS9FRWxtQ0R5WkJ4YnVJRDhObGdkdE1O?=
 =?utf-8?B?OUVMNy9wa29vbFhkRHdwY3U2SmNQeXZpaW9MaktXcmRIakFVRE43K0FkdmZv?=
 =?utf-8?B?dzFJcnlWTGRLWFpZNzhBSUFRcGwzUFlkODhNa1Zlb3VVZmdDTzBDQ2JGR3dz?=
 =?utf-8?B?NG9zSUkzeEZYWUFyNzdzc2VFZkpaa3luRk9DRjdFb2JaWWtJV1A0Z2pDSkNN?=
 =?utf-8?B?b0JDSlZUejlxN3YxeUlTVzlqK3NRNUQ3c3p4Mi8vQnBVZWRGMkNLV1p4bVRC?=
 =?utf-8?B?YTVrbzQxYXVleTVEMVpEcVI1VktPS1k5RW96NEZia05EM3V2Y1RLeEpzS0xq?=
 =?utf-8?B?TyswQ2tvRGFsSEJKV0s1eG5DK3dnSTFoWk0xcWpybmgza2wwR3lQNko2KzI1?=
 =?utf-8?Q?kW6rh9AhjMb3Gxm1hL4NXu4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aabaee0-f0c1-4b3f-a5c3-08dd33d9b242
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 13:53:45.0375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vXUVNl7vcuSuONhq7JDT0H2yXtSYvjn/fqozr0ihFWdwEZPwWjdsdMoQbQBR1hJ5dt9tWyktfrnkWkyyKCh4sczYhoQuzot46t39YmIl+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7650

On 1/13/2025 3:46 PM, Rob Herring (Arm) wrote:
> 
> On Mon, 13 Jan 2025 14:07:02 +0200, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Add S32G2/S32G3 SoCs compatible strings.
>>
>> A particularity for these SoCs is the presence of separate interrupts for
>> state change, bus errors, MBs 0-7 and MBs 8-127 respectively.
>>
>> Increase maxItems of 'interrupts' to 4 for S32G based SoCs and keep the
>> same restriction for other SoCs.
>>
>> Also, as part of this commit, move the 'allOf' after the required
>> properties to make the documentation easier to read.
>>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   .../bindings/net/can/fsl,flexcan.yaml         | 44 +++++++++++++++++--
>>   1 file changed, 40 insertions(+), 4 deletions(-)
>>
> 
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.
> 
> Missing tags:
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> 
> 

Hello Rob,

I just wanted to add the RESEND word to these patch series because no 
update was made with respect to its acceptance. Following [1] kernel 
documentation for submitting patches I was not sure if by adding the 
received 'Acked-by' to a commit it will still be correct to add the 
RESEND word or I should send a new patch version on this series.

On short, my lack of addition for the 'Acked-by' was not on purpose.

[1] https://docs.kernel.org/process/submitting-patches.html

Best Regards,
Ciprian


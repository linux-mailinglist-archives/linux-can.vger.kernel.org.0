Return-Path: <linux-can+bounces-4373-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D2DB351EE
	for <lists+linux-can@lfdr.de>; Tue, 26 Aug 2025 04:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675291B2844B
	for <lists+linux-can@lfdr.de>; Tue, 26 Aug 2025 02:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E4C278751;
	Tue, 26 Aug 2025 02:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="EaDnGIiq"
X-Original-To: linux-can@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013065.outbound.protection.outlook.com [40.107.44.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784001C8610;
	Tue, 26 Aug 2025 02:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756176842; cv=fail; b=IongR3mgNGC4kL1csukFRMs3G85+MNVEzAYJmCU4YEg83JQpiQXERGrsaq85daXVEX0j5eZTpSEFHgVhCDbyk8DPVFJWirPlfKRO/1b3EktMf/q5vA2fqZGMbiv4WYIEPhQDOKyvVmERJsM1vPIP8xaAp37b2Iwyo14D1oUptWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756176842; c=relaxed/simple;
	bh=z8baz4iiMEuge8swiSjD+WkN09CxxxvDzB/M1exPbsw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dRQIiErLTVMKIMnLpGvikEDGTgb7NyWUF7dArmrNiVZRndMmmYcc5XNPVCDvj/+NZWFSvovsOJTJ3+MA9zCTI9MmS8Xs0SF0AFB7jGBVSwacPEk/l5n75cW9UseHSjiNAr6km0aPHOgpjpZBU7XnDET683oailNQ5X6S6Xo6Wqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=EaDnGIiq; arc=fail smtp.client-ip=40.107.44.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUVRRgfy2XpzR+P1aYKBe3FMSnEK2BkCKM+7Vq0tlxaSPDLgMLPqoxn5+ylWqGUi4rMSjxrikMPeJKA0S2iJ2gILuPGnwKOUUeqct4opqOyO1Z5pO/cHKNUAXDOPtdKU0BrTDys8SdnHegR8JX+bWyBngJ2CVhQUPNQQvpmAI+kzooeRqAnXUv9397ugYGeELaj8nXkBBiyKmoUny8GlszXdnhFO8TayCAyx4VBp15loxBxpKGR6Sh4QVXTM1UAI2YB5ii/4aoXRKehmlLMsqE2N0oGzs+6ESlViRSGX7GJ7yNAT4PQO7YQ+SGBHLXR7Fkbi3cb4pgdZ4KwaYi4kag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8baz4iiMEuge8swiSjD+WkN09CxxxvDzB/M1exPbsw=;
 b=WVSA36Kp8XkmF86bZwRkUSJR1GBswdUarx2za/IgpqNAaoG8DvZf5FJN6ZTQ3Pf2w08Wlm4X8/TgHFa16+PvAuFLmvngTPYpfI7qWck7fmSc0GGfrLQpMg+udEYpvqY5cOLyszIp5zDBiFNQb24AueOd3PQKywVOx1WsbUM5kBoHO1MvVpJYE3bKB0hMQrH+8s4z1tM2RJ/7E4MgRZP0vjxq81mGFyROgD4okcTebMlPkzaBYfv4uvU3AOBB6bOHEmv+/WSoBEXbYozMxs7QQkK70evuTIuLQAlP0ICMbfDDxi6t94pV1Hx+BhcuVtppaCmUfdebahAk8Y/n4tIL5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8baz4iiMEuge8swiSjD+WkN09CxxxvDzB/M1exPbsw=;
 b=EaDnGIiqtE8y/asID8R9m6hEpFRWUVFC8pTTIrxRn73ht926b48+d70MohseOmgETLUCSQd3vLEBwSvnTsIbrXXPYN7sDyDfXhdoH/7OuyW6uSD6RBpLfAvPkDg9bvTYTvtdaEbvY1Vcy3PVuju3GKpIpxVk5OCkEm9g2VKVTR6KpxacQTPrZD51kClmKwm/xUKZIx4RT3GG2FvM4Y/TXYml1sNR7+VwLwThPus5v3Ol5YnpgpAxWiTwb0H0givwbpQyF72o/uNkjCUd+GM13J3STR0EU1H5HaW3fcfU9D/9RA8Cx7ee/PbnKubp/t9JIbuhRQCmKiH4TtQXoZu4+g==
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYZPR06MB5298.apcprd06.prod.outlook.com (2603:1096:400:1f5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 26 Aug
 2025 02:53:57 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 02:53:56 +0000
From: =?utf-8?B?6LW16KW/6LaF?= <zhao.xichao@vivo.com>
To: Markus Elfring <Markus.Elfring@web.de>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Chandrasekar Ramakrishnan
	<rcsekar@samsung.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Vincent
 Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH] can: m_can: use us_to_ktime() where appropriate
Thread-Topic: [PATCH] can: m_can: use us_to_ktime() where appropriate
Thread-Index: AQHcFZ/tGC+MP0aGt0qGzXKHGKSfKrRzmHgAgAClnAA=
Date: Tue, 26 Aug 2025 02:53:56 +0000
Message-ID: <0ab671c5-2855-4818-98b2-a52af4477e23@vivo.com>
References: <20250825090904.248927-1-zhao.xichao@vivo.com>
 <6ff39d21-5770-44da-9d1f-c4447b8baa3f@web.de>
In-Reply-To: <6ff39d21-5770-44da-9d1f-c4447b8baa3f@web.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR06MB6020:EE_|TYZPR06MB5298:EE_
x-ms-office365-filtering-correlation-id: 770f4dfd-1347-46e6-b164-08dde44bccf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|42112799006|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SzVtVGRiRzczM2xuQnVER1Fwb2NQL1hLb0JodHNSNmUwRUNDRWFwV3VzdldX?=
 =?utf-8?B?bGRWbEtiMktNdjRRa010VmdlbWtKYXRSNDZxZzh2TzZsY0dRek0yZ21vOEN1?=
 =?utf-8?B?MU55VW9IVnRIN3gwL25SMFpJSVN1TkN6L0xQVTdueXIrelI2Q0xGRFppZTF2?=
 =?utf-8?B?dkNERkUraUh1NXF3SjFXUWhsV2ZKYVlabUIwN05aRndJOExnU0Y1VTlpYm80?=
 =?utf-8?B?cThkZGxhakxmMHdrVCtjTG9IdVpKY2lpVUhQemE0bS8zN2RBc0tOMWR2Z09k?=
 =?utf-8?B?cC94ODFtNkZPamxOc05SNnE4eHRsL2ZmT1BYK2pHUU9naVpLRXFoLzFycjh0?=
 =?utf-8?B?YVNEMXVjc3hJVGs4by9XbDdja1ZRSTgxSnI1anVnNy9yZno0QjdLTEdCVEdQ?=
 =?utf-8?B?QzFIaU9EVTdKeGk5NDFGalpVMkZpTWsvV1ZTVkcwdnAzYzJ5Smp5UGNLTU9t?=
 =?utf-8?B?S2REKzU2bnE5UCtQSmowWENESXE1bXZrQUswRmhmVU1YYVBGTVlSRmpndUlV?=
 =?utf-8?B?WlZNcWNtZ29Lb20wRklLSEJDMEdScUdHVXJzUDM2OGttY0NINHpDOWdLODJk?=
 =?utf-8?B?dWJjWXU2N08xNEhVZjF0am9URWFKNGpqWUE0QW1NYVcvTk11b3d0NDZldXcr?=
 =?utf-8?B?SlRlT2JiSGxXWTlSL3hjNWtMTGRsbzFZbExaUkt2OXJsYm1HVUllRHEvUXQx?=
 =?utf-8?B?clErMjV3NEkwUDZhWDFmOFRwM3JqRUFSODJLK3hkczVKbEM1eTIydmw5Skti?=
 =?utf-8?B?ZURVVHNjU3JFQWNMcGtLUmt4eVhxajhqNEJyVTFqdHRuNTdZUW1kc3A3aVVZ?=
 =?utf-8?B?MjFJNW9adDl0OUh0R28rVVVxN0RqNXgzNTJzT3FIQ0hLVHRQRDl6TXQxdXE0?=
 =?utf-8?B?VGU2bS94MEozbW5MWGNxRGpaU0NxSURsNVNBWm9DZThpZEQ3RUtXVGJ3bDJI?=
 =?utf-8?B?YkNpYlpOdzltQ2pFTmM4YTVZaDc0Ryt5K25YTHZSTFZLMVZvMFVvT04zeWlr?=
 =?utf-8?B?QWU1VytsZU5Za3V0WXVYOGhUelBGY2k5Zm13Uk81a3RKd0JYMUlNR01rUWVJ?=
 =?utf-8?B?d1VQM0tMSm0wZWxnVzZMY1JibE9pS1l5cFFZaStKNFU5V3lNbEI1UDA2SEwz?=
 =?utf-8?B?STUwRU1PUUtaWWpOc1hWY2t1Qm1iSy96ZFZ4L21HcFlTMXorOE1NeGlBQkVJ?=
 =?utf-8?B?L2krSFNUS2d3aHN0dktYQ2YzQUJGSldESG5kcUs1SjBwNWdVMUxRZU56UEZN?=
 =?utf-8?B?S09ady9ueERYUFh4bnR1ZGNnbUYxMkhNL3AvUGl3U2dyZlBqTVdSdUp4VUYv?=
 =?utf-8?B?ZzlhSjZBWlk5YXY5S09IZ1dHZGcvbXYraitpTUxmT3VubXhMaDlPTjR1NHlq?=
 =?utf-8?B?Y2pCdHlWOGNDWUE5YUtaQitDNXZ2U0FNcFJRWGxWOFFOOEZvUWxFV29QMC93?=
 =?utf-8?B?azJPSjJMV1ZrN2xkWVVxUXIzczdvaUxlVnMyUDUvVis5bEJtRHB6RzF5N2Mz?=
 =?utf-8?B?a1VzNXFNVXByNC8zTE9lVEtkN1JHVlFJaU9IUXJBak1Gc2sxa01ZaFMzMlBX?=
 =?utf-8?B?M0s5WC9LZWdGUkEzRDcrOXY4bFFRbzNsRXFQRzZ1a3MxOVNiNW9BQTdlTWZi?=
 =?utf-8?B?aStQMkJ5TTQ2eVo3OVBSQVNxWGpvVDBmQ3B2QzR2M2F1WWxlU1M1TXl0YnlY?=
 =?utf-8?B?R005VHdaSDZYV2wyMWtvSTRHcGd3QzVOYnBac3VNMXY1ZGFnTUtLNjRWSWpm?=
 =?utf-8?B?WS9YU0g5OHp6SGhCcmN2c00xcDM5cjJPRFRETXZCSzJCOWx3eDVEeHFPTGox?=
 =?utf-8?B?Vzc0dGo5M3ZXZ1I1V2oyNHE0WWh4ZWtaUGppaUE1eE0yUXNzdjFBYnZRdk9t?=
 =?utf-8?B?bkMrdjBnTjJOVmh2T0ViQVRsVEpiOWQyUkQ4RmcrNFhMNHlQT3dYaDU2eWVJ?=
 =?utf-8?B?cGF0cU9vWmVkaTRWWjdlSFY1Z0V4YVFJUVZQaHlNSUNvWms3a3hVZStjTkJO?=
 =?utf-8?B?ellpMWRYZ2xBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(42112799006)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S0hZRzdUQmhTZ0ZZajhocFJzUkUzK25tU0RpTVdac1BKeEFQd0NZcldaSFZz?=
 =?utf-8?B?U1lFKzBNdm00YWNpeUJ5L1JWMnBNNXpOOFg5a1FSTktlb0p3UVNkNzVlZ0FO?=
 =?utf-8?B?TitxNHVoQUsyVThMSlpJVldXQ2xLaDRNZ084cnNKRGloTVB0RTRFaWRHTzRU?=
 =?utf-8?B?QUdjMlFQZUVtUHJXM0xiLzVXcDZjVlZYWTJ5ZTR0dERwZlZ6RndZOVZBWSs0?=
 =?utf-8?B?RThIM3NqSXorc3BBZTRSL0NRcWltSU5YTDE2UnBtU20wTHRkd3RSSHpVWmUr?=
 =?utf-8?B?K3hwakdXb3Q1ZGoveEVCZUFtckhhZEVkb05uSW0xOHpZQ3ArME0rbis5VHpL?=
 =?utf-8?B?K3hwQUwrMjhNck1OUE0rc2xlaFNaVlYxbGMxUUdPcjg4R2xWT28rN0htR1lP?=
 =?utf-8?B?UUIrQlZoLytneS9PZ1A1ZmZuOERTdDkweDhrcHBPSUhRMkE3SkZOaGJyQk1s?=
 =?utf-8?B?RzJ5elloOHV2ZUpvUlNLTWRFWEFJTGQxL1k3NkxSblNGSVE4NnlUTGZBVStt?=
 =?utf-8?B?dUREaExIVncvczZrOFcxS3NoQzdMNXVJYWtva044Ykw4bW1pVHV4MWxCUXpL?=
 =?utf-8?B?bEhnWHRhRWlHM0lPR3lCTkNlaUxEUUN3MmFLTk40ZXZCd2IzSVVZSXNoZW5J?=
 =?utf-8?B?bTE4RldWTUY5MFZJYXZRWkpET0JUSXFvMEJ3bE4vMnRJZmhRSDlkUXBNNFB4?=
 =?utf-8?B?RjFidTQvUmlFTU5qV0pGTld6MHdjQlAxM3NiQUlqK0R6Q1hVRFV3UDB4cmtW?=
 =?utf-8?B?WkFHYkx3QWM3YkxKSDFtQ0QzSjZPVjZQUUZOYnluK1RpWTRBRnZnQUJpWUdE?=
 =?utf-8?B?OFY3NjFMUFhPZkU4V2dsOUtUanlhNWJqWmp2YzV0SVlGRUREZVdwRE5JOUkx?=
 =?utf-8?B?bWlNYkhtZUxPWWE5OFZhdEVvZEZsNXlWeHA2YVhaSm1CYk5MMm9QbmZLb3h1?=
 =?utf-8?B?U3dKRDFTdTZHL2NOOTlnUjFrdTBhSlJkempxM2tTeU1QSGdIUFI2OFV2eWcy?=
 =?utf-8?B?a0FxcW1RdnhlYUJqQ1ZvdzMyZGo0K2M4anRUUi9SQklZNitKUjh4T2dlNVY4?=
 =?utf-8?B?T2ptTElCZWthZUp1ZnJKTzJCdE9wVGJaNEgrNG5mdkRjeVZ0SldDcWc0UVhO?=
 =?utf-8?B?M2RxN2ZsTU5uV3pyVFl2KzFXOXhYMTVyUjlTbVVJQW04T01KbXdESVo3VGor?=
 =?utf-8?B?SSthUzc4d29MMHRtRE51emtVeldCc01hUmo0SzkxUDRHVndHQmpKY2dRNEVx?=
 =?utf-8?B?T1BMN0JrQWdXaENkWS9MT1A3VDVvR3B1Y250c0lYTEFKaXo1SjQ1Q2d5V0Q3?=
 =?utf-8?B?WDg4Szl6a0dwZnM2VG01VFk2MGxUVVN6Z1NZUTdVcGoxbWR5eUFoNVlZVWhw?=
 =?utf-8?B?OUtLc3c0VjE3RVRFYzhVODlXT01SdndpbnlEV2JSajlCTzhTWkVmKzhIMkpy?=
 =?utf-8?B?VVRBRjlOc3c0TFJ3VmFFbDJCL3ZsTVovVlViVFQ3RFJSQ3pCNXFad25qN2x1?=
 =?utf-8?B?WFZLRVl5b0xnRHh4eXpsc1Z0cDZaQmVaYmF4aTQzcnJhM0NYdS9MaWdFMzE3?=
 =?utf-8?B?TjdLZkpqa3lxU2JqMkEvZStCdy9hbjlqTStVZUxDWGR2TDZVY2hPeXl2TmZ0?=
 =?utf-8?B?MmpVbjNyYTZGbzA5cU1EcVpyZURhL1Z2bURMQ3lCaHFQby9iV1ZEdjFyMzcv?=
 =?utf-8?B?MCtzcVNiTWdhUVhjdWxNSjN3RU0wS3hBc3pFUkxlck5XMkVYYjFGZS81SXI3?=
 =?utf-8?B?SGxGcVBQU0ZZcjlzK3ZCemFuM3pwbkNIclEvQVFKZWJVcktFdUs1YmlzRXlX?=
 =?utf-8?B?NDl5ZERmeW14ZEwyd0F1V1FpV0QvOFJqSEZTMjlXNVkxclp0ZGx3MTYxS3R0?=
 =?utf-8?B?M0YvUG9tdmZ2bmJXR0kzTzBETnMvanpUaVB6aHV3QmsxZzZyOEI1dmNrazJ3?=
 =?utf-8?B?UDF1d2JMTjVkdFBpQU80TXQwVjhXaFFMMWNyZndMbStYU2dJQU1hdTN6amJm?=
 =?utf-8?B?NnRWZDFvQ3dadjVnMHAyVGJDOS93cVZiNXg3T2YvdDJYVlRuWWR4OFFjakVQ?=
 =?utf-8?B?NlJ0NG8xU1RDcG5iZ2NHa1lUSFY5YzJvQ2l0MU1aNUgwb2ZBazY3RW1aVklV?=
 =?utf-8?Q?jcAQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3CAA1064FE9F947BBB98134309F9B76@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 770f4dfd-1347-46e6-b164-08dde44bccf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 02:53:56.8678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOwpq2QUJqLNqzB4WSL/VK0CePFiD9ixd7ZiJCIgXsmFsaJdrLL1KvxWf687TCzmN7ltE3CMTnj1zGZym004TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5298

DQo+IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gbWFya3VzLmVsZnJpbmdAd2ViLmRl
LiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91
dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4NCj4+IFRoZSB0eF9jb2FsZXNjZV91c2Vjc19pcnEg
YXJlIG1vcmUgc3VpdGFibGUgZm9yIHVzaW5nIHRoZQ0KPj4gdXNfdG9fa3RpbWUoKS4gVGhpcyBj
YW4gbWFrZSB0aGUgY29kZSBtb3JlIGNvbmNpc2UgYW5kDQo+PiBlbmhhbmNlIHJlYWRhYmlsaXR5
Lg0KPiBXb3JkaW5nIHN1Z2dlc3Rpb246DQo+ICAgIFRoZSBkYXRhIHN0cnVjdHVyZSBtZW1iZXJz
IOKAnHJ4X2NvYWxlc2NlX3VzZWNzX2lyceKAnSBhbmQNCj4gICAg4oCcdHhfY29hbGVzY2VfdXNl
Y3NfaXJx4oCdIGFyZSBtb3JlIHN1aXRhYmxlIGZvciB1c2luZyB1c190b19rdGltZSgpDQo+ICAg
IGluc3RlYWQgb2YgY2FsbGluZyBuc190b19rdGltZSgpLg0KPiAgICBUaHVzIG1ha2UgdGhlIGNv
ZGUgbW9yZSBjb25jaXNlIGFuZCBlbmhhbmNlIHJlYWRhYmlsaXR5Lg0KPg0KPg0KPiBTaG91bGQg
dGhlIGluZm9ybWF0aW9uIOKAnHdoZXJlIGFwcHJvcHJpYXRl4oCdIGJlIHJlcGxhY2VkIGJ5IHRo
ZSBoaW50DQo+IOKAnGluIG1fY2FuX3NldF9jb2FsZXNjZSgp4oCdIGZvciB0aGUgc3VtbWFyeSBw
aHJhc2U/DQo+DQo+DQo+IOKApg0KPj4gKysrIGIvZHJpdmVycy9uZXQvY2FuL21fY2FuL21fY2Fu
LmMNCj4+IEBAIC0yMjE0LDEwICsyMjE0LDEwIEBAIHN0YXRpYyBpbnQgbV9jYW5fc2V0X2NvYWxl
c2NlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsDQo+Pg0KPj4gICAgICAgIGlmIChjZGV2LT5yeF9j
b2FsZXNjZV91c2Vjc19pcnEpDQo+PiAgICAgICAgICAgICAgICBjZGV2LT5pcnFfdGltZXJfd2Fp
dCA9DQo+PiAtICAgICAgICAgICAgICAgICAgICAgbnNfdG9fa3RpbWUoY2Rldi0+cnhfY29hbGVz
Y2VfdXNlY3NfaXJxICogTlNFQ19QRVJfVVNFQyk7DQo+PiArICAgICAgICAgICAgICAgICAgICAg
dXNfdG9fa3RpbWUoY2Rldi0+cnhfY29hbGVzY2VfdXNlY3NfaXJxKTsNCj4+ICAgICAgICBlbHNl
DQo+PiAgICAgICAgICAgICAgICBjZGV2LT5pcnFfdGltZXJfd2FpdCA9DQo+PiAtICAgICAgICAg
ICAgICAgICAgICAgbnNfdG9fa3RpbWUoY2Rldi0+dHhfY29hbGVzY2VfdXNlY3NfaXJxICogTlNF
Q19QRVJfVVNFQyk7DQo+PiArICAgICAgICAgICAgICAgICAgICAgdXNfdG9fa3RpbWUoY2Rldi0+
dHhfY29hbGVzY2VfdXNlY3NfaXJxKTsNCj4g4oCmDQo+DQo+IEhvdyBkbyB5b3UgdGhpbmsgYWJv
dXQgdG8gYXBwbHkgdGhlIGZvbGxvd2luZyBzb3VyY2UgY29kZSB2YXJpYW50IGluc3RlYWQ/DQo+
DQo+ICAgICAgICAgIGNkZXYtPmlycV90aW1lcl93YWl0ID0gdXNfdG9fa3RpbWUoY2Rldi0+cnhf
Y29hbGVzY2VfdXNlY3NfaXJxDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgPyBjZGV2LT5yeF9jb2FsZXNjZV91c2Vjc19pcnENCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6IGNkZXYtPnR4X2NvYWxlc2NlX3VzZWNzX2ly
cSk7DQo+DQo+DQo+IFJlZ2FyZHMsDQo+IE1hcmt1cw0KDQpUaGFuayB5b3UgZm9yIHlvdXIgc3Vn
Z2VzdGlvbnMuIEkgaGF2ZSBpbmNvcnBvcmF0ZWQgdGhlbSBhbmQgc2VudCB0aGUgDQpzZWNvbmQg
dmVyc2lvbiBvZiB0aGUgcGF0Y2guDQoNCg0KUmVnYXJkcywNCg0KWGljaGFvIFpoYW8NCg0K


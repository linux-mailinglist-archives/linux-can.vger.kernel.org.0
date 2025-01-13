Return-Path: <linux-can+bounces-2608-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A73A0B659
	for <lists+linux-can@lfdr.de>; Mon, 13 Jan 2025 13:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E9E07A1740
	for <lists+linux-can@lfdr.de>; Mon, 13 Jan 2025 12:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C153722A4CB;
	Mon, 13 Jan 2025 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wj69DYa0"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9890B22CF30;
	Mon, 13 Jan 2025 12:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736770033; cv=fail; b=JZgxnjSb+Rrb8PEjua1BHZDP6VNGTngFGeeyvG35YZHZv0W/tYfeEriYqSJ+P4rTSqnIkNFukESNLKSIQIO34YT1HpN88cfWeNISwFaS+ZKmhuaOMs90pIy+1sFJRNBLMM48SH+8oeUEcEdOBV3eW9ubSYWsld6RAmVn4JqQTbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736770033; c=relaxed/simple;
	bh=effikDis1puXumgaNiicY+bwuwQW4y+vwQJbe/KXjB0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oHoi2vIh2/mYmvTz01aZTwd4QfImL1oC/sPJA54lg6hOHJQ8wceca6J0RTksJJ/gbmuO0y7PMGt2hTZDxYIxaa3fzWdG//QvMWFL9Z4FHbc1VYJgdV1E5j+Its+8IDKcRxl5Hsvkbw3+nCsNsdNvbcP6o03rY0sjS/vqfM7d9f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wj69DYa0; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3kIlrpfhS1UovbzfpNCGYTA7+Oy/OYXQITFS5VI4B3fMeiyKIXZhizgJZ2p0pEODqWQalz1CHUYsFHB4kQLeDX3HdnbVgTHp+xbHkBt1AJx9hdbrOiX1UB4xl72lkvqYebre+odYwQouIHpzON4Qwn+XtZEzIMkCW6hHHafzM2Gf/2GBcRUemhJfu7baK1LIMfkzGseeaGEdOn/buS0IOMGdZDboLrppn+SM0L5C0YMijE7WP+DUmghJ3EVaQc0R0iZ7lWadPuZQR0A33Q/uTQohjqLmyLnC+hfsz2F+gL5q0tPa1hpf1nFFeFCHZuwsF9skZ8kxx375HmOeLllZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd7eyrW6paO5m3DjOBya/f3hTzTxyhWGtIDUBgc9h6s=;
 b=tUJS18Bj+1uhJeb5hpBxyTmfugKqUs+Dqf89Rf3s5chX2/rhIH9ldJwg0Cs7tkmLiZ5aPBZ+MLnXymXzWsI9zMTDiYCQwR9yyNUvXvE6oa2FEtzQyOkTsvJxjNTeAEbRytKbXieOFATxV+yVaY+esi0GLGRraguv4cLHpk0jTWIgZ7iMNBU6aPQKG7qqQ8hplOxGgFn1KiyzLftgt8eZ1molD4O8O7LU9i8m1lHO6+eAJUdgk458IFOzPtXNW9vl+FbjTzPLo6vMm/H+CaotnWEud5JnV4+rm7/MHUV9vUq7YFSEfw34YbMxncg1YhW5ODWulPMQkz8PKb727PrTJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd7eyrW6paO5m3DjOBya/f3hTzTxyhWGtIDUBgc9h6s=;
 b=wj69DYa05tZeAPAggNLYOUuxmSZFlGpxrXwVdcwRVkZv4OK2pYP9UVu6VW54rWZJ+LUdw8ibT3kflSch3D30BL4ZDaJaUXJmrPnGCJDiWMFi6yNaEa5F+yzs7OfrxVNkQ+p0E7sWfqar8HkHmOrrNC13INd5VkFUh891UkIWj6YIMORSvbN75IwwIbLLm+12KRJWLJw0qHfBR4vQ3LUf0oWOkoSjzOpAByZ6fqEJUWcQjpNJ34RmzRmUkPxbTbZmloMrSqsv+hf5vf5W1tTj/rHgV6fcMY5wbXe+EhaIPhEr52Ljw8HlVYFOSGy2nnOrGYfMKX3zxs5J3zKKAIcVlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DU2PR04MB9066.eurprd04.prod.outlook.com (2603:10a6:10:2f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 12:07:07 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 12:07:07 +0000
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
Subject: [PATCH v4 0/3 RESEND] add FlexCAN support for S32G2/S32G3 SoCs
Date: Mon, 13 Jan 2025 14:07:01 +0200
Message-ID: <20250113120704.522307-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0013.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::23) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DU2PR04MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: d2bfe25b-b4f9-4de0-6a4a-08dd33caccdb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0pSUE1VWVZuTFV3NDRyU281OHhvNkdPTTJRM0lydFE3VlpGQXRLa2VBN3dV?=
 =?utf-8?B?UzRwREhydXJHMkdWQS9VRUw5RjJjRkRqaS9GT3k4UGJUQk9DVG1wcFVwY0RK?=
 =?utf-8?B?dGRrakxLS1JVTzAzWnJXakFJQXRVTlFqcXZPbXcwQUI0a3FweW1MYVhJNWNM?=
 =?utf-8?B?L0tGaTVqMEJ6RFZFMnVtZjFtQmp1eElua2RFQzdHOVVOUmxDVGNvSEJtMXZX?=
 =?utf-8?B?SXVrMHMyNFA1SnpmcVM4dmhIOW02TWZ3VGhUZExUMXBIeEEyWVZRQjBNQ1pl?=
 =?utf-8?B?ZURJdGxmdERIczBZVWNKTWNZQ3JidDBtMkpkUndQWE1RQzYzSHR4S3VibzVZ?=
 =?utf-8?B?TFgrNkpaRU9tNDJnM3ZRdHFLMktMSzZ6cVF5Y1JkcGFqeGwyazd4TFRiRHMz?=
 =?utf-8?B?YTY4RExVRklSREJmRXZ3YWE1N1NvR0xqZnBDZmkzaFNKL1B4MGZsQzBLc0h6?=
 =?utf-8?B?TTNpZG9wYS9VU0lUVjJXcUtkcTN4Z1pSZVVEcFlYTEl1NDBjTkZFSHRIWFBT?=
 =?utf-8?B?UzFQQ2V4RkRyNExQSGpic1RMWXZzS1hzb1N6RGUwd01mcE8zVnRRKytiaWg0?=
 =?utf-8?B?SCtsOFJySUcrSnl0eWgvbU83VjZpUTd5LzZJbU9IVDdDb2NxVFRLWjhtOHNn?=
 =?utf-8?B?OU9TQ25QVXlBZkwzYm9NMnNuTVZHZGhaV3dsZHFpSTNRRGVLc1czbm40b2tM?=
 =?utf-8?B?UUk2dlhrYTA4M0FjcHhPMW5IVmdqb2NjUjRXaDFQQmNnQmFzOWMzdDFPQlpH?=
 =?utf-8?B?NVZVL2lJdFdaUnJEcEVJWG5aNWgzRVVoNmxmSDdxaGpxNDNFajMzN1pnNzZW?=
 =?utf-8?B?K1ZodmdLc01qOGg2K0FnNGJyUG1FWWZ1S1c5RFJaay9QV3lITTlSM1BGMFky?=
 =?utf-8?B?Y2R2QnFKTlgvUG9kNGNpQkR1VThvRlJ4bGRIbTFIQmRySFhRVEo3WTdaVTNU?=
 =?utf-8?B?UU1sMGRmdy9Cck5tQ1hvTytRV0dWdkk3aGJ5WWJJeXg5MlR5bDhkOFR3TTFE?=
 =?utf-8?B?T2RtL3djcWFWYmdoU3lSMEZiOFdHS0Zzb1Q3YTZwL05aNnVTVTVjNWNPZEJ6?=
 =?utf-8?B?Z2ZYanlZai9iZFFDUEQyQjNUTm9NY1V6MXBHRUI2c29ucU10czEvWXpVamZq?=
 =?utf-8?B?cGNEL2NkV1p4YnBYNjFVRmRVcWdrM1VNUmJjOXdueFFzNDFwMSs5WTFQT3Nw?=
 =?utf-8?B?YlVId3Q5eERsZXZMWjAwckRuUnlFNkRQZEdWTU5qQXdCRG9rL0VHRHh2YjNC?=
 =?utf-8?B?YWNtWkVCajlyTnhZZDl1K3RTbDFqMSswaTEvMk1qNE1RK0FTZEp4Y2Y4YlFx?=
 =?utf-8?B?amR6bHY3ZmtVRFAzTzZacjZNYlUxamRuZ0ZzOUlSTTZyalJrOUo5NEZNUmFw?=
 =?utf-8?B?NkVlK2Z6ZWt4MVRjcVc2YVFlR21SY0NmaHAyVWZRYng3Y253YVdXSnJWSjhS?=
 =?utf-8?B?OUxVSVRUUXk4bFZSenUzWklXODFFcTBWMlRoQ01seW9OdzIxQTYzU0dOdzgv?=
 =?utf-8?B?Ulg4aXJvMTQ3cWtneFc0RkFXdFdXVk5PTVErVHFRNjVUUytxejgrYVlITnQ0?=
 =?utf-8?B?RndpS2hxSHVWRTBsSU9HWTFCeGFGem9HbXk5cEMrVzlVTXBpYlE5SXFlUkRt?=
 =?utf-8?B?a1h3d1NKOS9FeXRUYXJUMzlmTldTQktjZUxSOXczU3F0am5kLyt4V2J3YzB0?=
 =?utf-8?B?SWJlR2lMc2JSaEFWVGQwanBPRDFBdUdROTF4cDBhTlVKMnF5NHVGd3RjRC9Z?=
 =?utf-8?B?RFdsbHRoNktIdWg3c1RJTFdEVzR6dENObThGTHcxQnczTUUrVjBud2tYdVVJ?=
 =?utf-8?B?eERrZjAzUkxVRDZXaWlkN3FXMmJCckh3dUJpdUU1dHdxNlJsaVdRalI0MmRN?=
 =?utf-8?Q?Lzj94o2ATIxNp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0tvT3lNRjgxQUp0NnVyTFJwbmNxdTRHSHBlUTZyRVBEN0NtT01rV2g3bTVq?=
 =?utf-8?B?RXo2aHNYMXIvOVNCK09RWjZ2L3pLdGFrakNYcWZLampLUStaZzRrckdzWWN6?=
 =?utf-8?B?UTRGeE1OMExaWXZ3Vy9YUGRiZExtN2VSRGszQitvaW1uRThZQ204ZFhaOFRi?=
 =?utf-8?B?WjBiU0JBcnRQS1dSZkdSV2VqWHlIVXNWb29vS2tUc1huRTRHc2lWM1ZvNmFO?=
 =?utf-8?B?N1AreHRGWER5YXpYRDdkenZlbS9rUlJqNU1BYlpkY1dQb1NLNEVQNVpHNjFI?=
 =?utf-8?B?d1F3ZTNMSGRrbDFocWVreFg2ZXY2aXVPSUVzWmdlNklVVmVBY3k3WExUL2hi?=
 =?utf-8?B?Q0syd3Qvak8vdFlrQjhpSE82RjVSZFpsZkdUNDZuODJsTDNsaEVXWE5yOFVW?=
 =?utf-8?B?RjFyNVcvU1JIU2tVUGU0WWpCeDJISmEzMFJzUUI2WnhBUVJ0aHVXeVJTdUo1?=
 =?utf-8?B?Vnc5SFF6Mnh1ODlqRlRVclNtODM5b0htRVNOYjU2eWRzSlNDYmVqdkRhalcx?=
 =?utf-8?B?N05XV2FEOGhGN2JrNG5FZHdYUW1xWjYwUmRFK3RtUkFJajRjVjJVZkJJU0Y4?=
 =?utf-8?B?ZXR0N2laOCtCVTd6dFZ0VWJXNmx2Ry96NXdTV1l4WldycFpSd2JOK0tOQlJR?=
 =?utf-8?B?TTgvcnpOQXduSFlTa0svUHhXN1ArNkQ2T253V1FXcGJuQUozVDhpSlMxVVRy?=
 =?utf-8?B?RnJ0aURGYTZTcmtaL0lKNExjb08zNVcrWWVSMDAweFlMekNkZ2tsbWQ4K2t5?=
 =?utf-8?B?UU1GZ2xzMEkvR0xKTkl2VXdZOGZaU1kxRlVic3BGM3FkeHlvWXN2UEdCeVRP?=
 =?utf-8?B?eCtoaW9WYlJhTE1YcUFabkVQYkNKSFkvZDRqSHFoMFFCcGpncHlpRFR2dnlR?=
 =?utf-8?B?TWE3czA4SjY5ZUc3NTVBZXRjL0U3Zm8rR2Fud3ZCMWFzNFhuRnVkN2NLYU9l?=
 =?utf-8?B?c2Q1NDU5R1dFVzY1ZE5GWlF0Z1pBYjM3RmdzWFV0RnlESWFKZS9hUVdqU1kz?=
 =?utf-8?B?M1Vma0d6bHo0RHRLM3BIUXVyZCswZSs3T0FNclUyRmdDVUluc25QeGdvcWtS?=
 =?utf-8?B?SHAzYmFZNDlIVTgzdFZMWTFLc3BaUmNBOWR3NlVpQzZ0UHdpUnVsdSt5bUVz?=
 =?utf-8?B?RHlhTzhCTWFPak1HUklZTEFNdzdhMk5JaXVLRGpVR3FiNndtcll4N2RHZXpX?=
 =?utf-8?B?QWNRY1d2Mm5neFFJRkJjZzRGdy9FeFIrbXJDblN4TFNaUGdEcWpOZnVqTm9J?=
 =?utf-8?B?Q2VvZVU0c0F6L01RK3A5NVB4Q2hVMnJaV09TL3JqdFJkYTg4NGhMd0plTHpR?=
 =?utf-8?B?UzFiK1dTR2V6MC9kSTF2Zk84S0krSFp2WjV3bkV0eXc3TTJCcHhqbGJEcElH?=
 =?utf-8?B?Q2oyWUMzd1BTTU53QTdYWGtmYndkb1NPTkxrZUNiQTV0MVB6VFplZE9kYUZz?=
 =?utf-8?B?emcybGkzL0N1b3NiR294dEpIYVBFV20wL0dHSm5qNTRReGZEbjBscDdvTWp2?=
 =?utf-8?B?YW9EbEUyMGtJSWhCdWVRWDlhd3I4NDlGUitZUEFseUZjcDJKMjU0YVlsaFpS?=
 =?utf-8?B?UGdONG00WTVGa0E2YWVoUVVQLzlKSUp0aWtFTHlVVVJpOTdtY3VFdUVpY002?=
 =?utf-8?B?UEovVzRWUEx0SEo5RkVhOEJoTmpvRDNUdVNaSEFIUGV4M25naWwyTzRDT0JD?=
 =?utf-8?B?MnhFc1hzTVJuUURHK3FBb0s0NStqNTRWbmZJUVRwMGNXVkFtVGw2UzZFVFhI?=
 =?utf-8?B?NTVzM1liSGxZV3Rrb1crQWtwamMrRFlqK2xHakdER2pjTSs3QzUvMEl2ZlUw?=
 =?utf-8?B?MUNLL2pUNXYyVUl3dUFMVDRHbW9YcFJjbWQyNWY5eXIxb3djZFlZK2xGeW0x?=
 =?utf-8?B?QWlGMzJEMGFHZXpTTnZMdmhKcXkyQkNDNzJ0SnFyUzZuWGZwclZyQUw2WWpa?=
 =?utf-8?B?bmhWUVpjL1kzbkp3UjhGZnVIUnp6SDBXR1N1QVA5R29SbEFKb1MwTmJVKzZH?=
 =?utf-8?B?ZjlKWEl4cGVjSEN2ZThEcWgwYnZKODJ3Rnd0cGx0ZHNTOVY4MVR6cys3QUwz?=
 =?utf-8?B?UnpVTUFLQ0QzanhCYUgrazJLWGc2Smw1REUrQnBiUm8wYXlpTXk1VjY0U3R5?=
 =?utf-8?B?VjI3dHNWSmtTTWE3ZGxGSHFGZXkvS3BPS0NQU3I2emF2bTgzNU1pbVF0VUw4?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2bfe25b-b4f9-4de0-6a4a-08dd33caccdb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 12:07:07.3420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /owS/VNX98y0j1u7aKLarlt2qHpi/guDRm4tht4AfS3Zh1LDnegALvlGX71qrZt6Odgctz6KnHw5SSNOV2LEy2VwB4KymDdpSBktWUPfq2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9066

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



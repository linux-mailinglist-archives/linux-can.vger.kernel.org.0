Return-Path: <linux-can+bounces-2107-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9E99D2152
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 09:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10832281260
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 08:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A65619DF99;
	Tue, 19 Nov 2024 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kPKTAa+K"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9143B19B5B1;
	Tue, 19 Nov 2024 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732003868; cv=fail; b=iijtqPbb7noiKSBfIj0YswWg6y9XxLfQ+pKunJcYzjq/4T2v50DSHSTWRu8yyPxqacTGJ8WBBaxyBlaugbGRP2vPGiXtn1OrpRsc3ocM3VzmVNgXWGiVZ1bPob0f25c5B8rZrwrInt6iWb9AgtztDqJulzVd2B30IPJZy+OB2wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732003868; c=relaxed/simple;
	bh=s5GyuIVsTRuB+40aK1xPdi/4m/eU1k0HoIdFk2wTwjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g473NrwVwUstUiYckV6CPo6xv8S44NbQR8fqEHBHKj32iOz/FBZBv4bUTiUffgcWd0WE5a7DzxttmNlvgK9U6uiS2OZxr1Gd6Go2oTqsfrQogitH9aFDfM5c5Mz4uveft/nmjCfmKNeshPqelub6lr0bXFu87Koe5/s81gwOSsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kPKTAa+K; arc=fail smtp.client-ip=40.107.20.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vh0t5IynW+TGrZF3FzA80y5xXy8JGi2H7L24bSv5Yuju4eeSc+2PC6dm4wnIHuqQOQOBFjM+cNpGIiMJNEvWYjku6nSUiaRZ7vxgTIuFV+q2wStr8PZhf17m6aRtPoWAM67B4Sm3pI1NRSVciqySA+lnDXPqrS+T+ORk58NxOSN8koksTtFMvGqn04cZpgKnn597F4oed0OEVWwth+WIBOVOtcWr6HZ08EbjC+q9AM5plQH0gH1D4qDWL3k1SEWqQdT8FW8KHuoe7PWbpWXKRlTnuT/nAPvVo1jXig3zMk6ZPl4r5rVwJlife04ERyTY11Usu12jVx6iYuRCIbL/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQz1hpJ7w6n4hw+ZQnp6Vi37ibD95Iux605dlxQo19I=;
 b=dBSei8sb+V8AsX4deYpQB/GhbFm7EtTHUOUEPXYfExBYD069gspxx5bDqf4nboKnjdzV/bZnobcv/mVCSNvo4pZCp76UXFF4hWEccc+eP7G11betz+vGAkL6zP+nmwKaOxS01xUpazvbwn/kNvaGA0k0VM5biFL0cirvfcsjlbLEriWdYQ50XaQ7D8Bske834JyD8ChZkH5zsY17gYDTAmhxSAPMfVWoxEnldxibx5bRk7sDFFSP39C2jS6q2Ka868KYC7CubLx7lxFFTAP4E9xdcCe8WEexjYdG3JSmrqeGlyaY+9l3A+gNd4aAx4T85m90p84bP/f5/UKm3Fv0Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQz1hpJ7w6n4hw+ZQnp6Vi37ibD95Iux605dlxQo19I=;
 b=kPKTAa+K/7RzPy/JQDgk1rfP7QjiNZ8z9A1fBQU163qk9djPbj1x1LJxaod8bxUmcskhgdrMvjIYytVbUJ/snigMjyWb/6ztNWZ7EhGpKO/Dmps6gOOUxlooWTWYsHdZt90OMsTZiXHwWBtFpau+18GKNiCrjjWR0upPVESZpwW9eeuFexPNLDROuNfXc3Nb300Xw0aqfCFT2Grb51ybcN7aOyilcQKxsHRS79tGSohM+TtHACaX8CIWoE1D74cTrbACwL4gcu4Q7mXcx5HYDWwC1tlfa2okZMdph77cR/0G53+HO5/Uba8KjtDFSMHMckHVLsTuxLXAub2ymURtFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 08:11:01 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 08:11:01 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	NXP Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH 2/3] can: flexcan: add NXP S32G2/S32G3 SoC support
Date: Tue, 19 Nov 2024 10:10:52 +0200
Message-ID: <20241119081053.4175940-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
References: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR05CA0003.eurprd05.prod.outlook.com (2603:10a6:205::16)
 To DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM8PR04MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: fa80d4aa-0d7c-47dd-29fc-08dd0871b4d7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eElZSjZCZW82ckJqRHArZFBQWUJnUjNzK0x1R3BQNjVubW1LZVN6b2FrcVBK?=
 =?utf-8?B?c1dpcTFHNXQyM2Ira3hPaEVLREp6TUJsTHl0R3pRSUowbDNhaUdBaGdQK2VB?=
 =?utf-8?B?ZzZXRE82Nm5VSmZGQ0JRSGdqRURFWG5iaDFpRWhtdi9UTXJlM28yRWpkdlcx?=
 =?utf-8?B?QmxLQXQraHpzeEFtQVVQc1ZSSTVBZGpHWGMwTEFsSHJpYmV2NjltL2tWZmZX?=
 =?utf-8?B?bTFwK1dFYVpoVTM3aERmTFpxb0ZsUVdXTXlNd2F2YzJWNWdTUjNNUy9tMkI4?=
 =?utf-8?B?R1czc01JWEJkTUQ4Q0JlQm9UeWtLYjYvbXRkSE1wK2pyUXRDM01UZ1JMRGhx?=
 =?utf-8?B?blZ4d0hrcENnSm1CWjJnUEZtU1FjdlFmemZqdzVGZzhLUXFEaHVwYTlKL2FI?=
 =?utf-8?B?cHJVL29vRFBJemtDRGtjVmdxYzVXcy9Tb2dnaEJpakt6UTNsOXhVNk0wVklu?=
 =?utf-8?B?bWw5ak8wYS84aXZzNm04ejZrcGdQdGhEWml4T01ZVmE3SHZvc0kwYnlTSEZj?=
 =?utf-8?B?azAxUHI3NU1Zd2FsKy9sVXJCQjVsb2JOVVpocDRtbE9GSmpEMG9lWXlpSDl3?=
 =?utf-8?B?bVJVTkh5L0xSbFdIaTFyMFFyWWVKcEQ0RlIzdXR4TEJPazZFRDU4d3I2NjFh?=
 =?utf-8?B?MWc3SU54RU5IQitJdkJSUVdwRWZPUzdoTTRRVEtJRVkvc01JcjJybXEwaGRV?=
 =?utf-8?B?a28rSGZOVEh2b1pla0tyQk0vNHIvZWVxeFVzWmhic2J3Tkdja0NxTkdjQWlU?=
 =?utf-8?B?TEJsQTBVZlMvUFl0OEtVakdMWkNOdDEvT2NhM1UwbWk1NkhZcnhRYXIzS0ln?=
 =?utf-8?B?WEtieVFIRUVha0dDMmc5VHBTQ00vWUs0dTJwbi96Q285Ulg2aEt4NVg4aG1i?=
 =?utf-8?B?dGRDMkJWaVduclI2bVAva3d3dTlzTHVoOXIrOUdNOTd3S2N4ZFJCRHVKa2Y0?=
 =?utf-8?B?MmZLMlBWcStVem5BM055Rlc2bVllRjJlZnZsbHZybjh4ZGRLSjBLNnEwMmxW?=
 =?utf-8?B?bERSbVRYL1Z0OHNnRVFFVVpIdWRsa0tHendoTUtxZFBUdjRpWU9vL08zd043?=
 =?utf-8?B?UzYxUEZZMCtPd3QzZFFMSWhGZFBZS3dQU0tTMm9iN2lOc3pXby9JN3hnaEdJ?=
 =?utf-8?B?THFLa2FFNjNnbFhNaGdidVRJMmNRNnpIM0pDR2p0eE5FWW5qMy9vdC9ySXE4?=
 =?utf-8?B?ck5xTWx4aUt1M1djSzF2cGJpVHZVQVN4QWNzNkdkc1Q2bFJuODgwRVI0OGlC?=
 =?utf-8?B?dnp1K3VTMXp3MGgzNkZySFZ6NHM1UGMxTm5oRTNNc2ROWHh5VyswVjRPRnFJ?=
 =?utf-8?B?QkpMZURPNlREYnB1eCtPUU8xd2orNkZnc2FCK3FKb2ZzWkZGd1Q0VTlHRWxq?=
 =?utf-8?B?MjRpUnBNTzFQenJRbGovZVV5TkwrclBKb0dpS255VXVERmFNRDRZL2w2RHBx?=
 =?utf-8?B?R3grUVJlUkNDT2NGdmtjSlpHSUhZNzVxTmlleTVMNHdwbCtwWllOSFBZRFNZ?=
 =?utf-8?B?ajNxOFR6VUlhWDJEWEZZRUZHRWJ0MHNSVS9VQmpKeXFvVEliOXpjQnViOXl3?=
 =?utf-8?B?aE92dlRUQ3JzeTFVRER4UUI1akJFWm1jWDhQQmNhWTRtQmQ4VnhZeGF6ZlZR?=
 =?utf-8?B?b0o1aFRUUkRGenBxc0U0ZUtnb25nTHlNN1JJR2FsWXdhcG5NeDdBc0xCVXFh?=
 =?utf-8?B?QVlST09xS1MrZmN1dUJKc2dUbC9JRnJvRTIrVnRYVFVvOUYwZTgyME00Uk5H?=
 =?utf-8?B?QUo1VU9naTl0aXFYMkkyWEhsK0NFdkE3R284cERsUjNLVDdNV0c5aFpJckhM?=
 =?utf-8?Q?VANkdOvplzoeUspXNktxp3PeUO+O8bDbO7cPw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1ZMTTJVajV5NUxqUG5paDhzcUJaZWc1OFoyRnVKenZjSWRTV1JhYWVHSFlh?=
 =?utf-8?B?R1ZiUjZxaUpXMFdDc1NEcS9yUUFhcWgxSFVBRWNScS9vYlpUUXlIWDkxZlJm?=
 =?utf-8?B?SE9SaVJMTmRiK3NRSHF4SmlRTStsNk9EZzRzbWc3b0xWamV6cVNJV0JydExN?=
 =?utf-8?B?OFJEOXA0RWNkMHpBd2tHTG1LYytVS0FTMHZSdjUrL1ZOYzY2OW8zNC8wRnhL?=
 =?utf-8?B?V0ZGVkVnVXlaR2Z6YTUvcjdqWi91a3I0K2FMMjBIVS9VZ1EyT21hVkNTc1Rw?=
 =?utf-8?B?bmord2N6Nkc1OUEwKzRPcTF2bjl6U0g3M3ZMNDdFeTR2di94R1Qydmp4NXdK?=
 =?utf-8?B?UXVMV2xWdnNPdU40dU44Wit6cERUYXA0bXBUOXBBRkpuQTJ4UHF0aHF4cXNU?=
 =?utf-8?B?RExlazh1VFBZakFwYkdTY3FTcmpBeHdVZVF2R1NtREF5MXEzOVJOZ1JDUVFa?=
 =?utf-8?B?OUdVVlNJRVNwZHJ2YWFFdVdkRG9xbXFjRXlRejV2QlRmWkNRYWFTSEdnSk9S?=
 =?utf-8?B?emhUdHNNRXMvWW56MnVNemRnQ2h6MnhxbTR2TUhOclRiMW5VZnQySDFzd2wx?=
 =?utf-8?B?MjRCaS9jSW5iZVJvc1F3WjFCQm0wWU9XMWlscHpvQUE0ZU5xa3d6OW9pQUxo?=
 =?utf-8?B?b1dWNkJxQ2dDenF4Rnc1QTlKMHhjNjJGVDF2YWpIZlUzY1hJTndmM1BSaU13?=
 =?utf-8?B?ZXZ4OXhVMnNTYmFvdG1oL0RpMkFtZS9KWkhLbWVLSnd5emEvZGdXZThxMG90?=
 =?utf-8?B?eTNKZFFZN0RIM0lRZWxlL0tSaDFBdDVaQ0d4VDFKeVVIcFJkdDh1YUxTOENr?=
 =?utf-8?B?blBIazFqN1BCZHNIeFU3VGI0YU5Bb3ZqRDFvd1VRYTJ5cmY3cEY0eStNZFk0?=
 =?utf-8?B?K0F6bHZISlVKNXU2S0x4K3JkL3IzZmdyRUYveXZqd0RkVklhS2dTdzZPL0tm?=
 =?utf-8?B?NVJPdFY5WHJWUEQxU3IzNGFvSzhQRHBtbVkzaFdyaXB3c2ZGZHRKQ2tzM2dj?=
 =?utf-8?B?Snl2Y25ZT1VFMERtYlJkMCtsNGVhOTYyMUI1OGdJeStJY0I0MDFnYm5YTjhD?=
 =?utf-8?B?cmk4VkFKTWIvaEtkdEZFakFxeXZsdzFGRkl3NXBJejNmVUx0OWxEVElXNmVv?=
 =?utf-8?B?MEFOUkQxa2dHdklIdjNDZzg0Uy9wQm1JZE1NMUVndDNudW1BdXZpZHk5UE1y?=
 =?utf-8?B?YVQ5WUN2SGtiWFpwODJwNURiQU8wVHdJL1ZnbFNPZWlaUndoN2g3MDBzUTEr?=
 =?utf-8?B?QXBpajl6M2hzYkJ2Uk53U3U1NXlsYlJEQnl5MDlSSi9Ua2lNQ3p2VHNYSU93?=
 =?utf-8?B?c0cxQ2xGRU83R0l6OHBYaWw1WlNNaGczTFh3ZlBTU29wYlY3RzZNWFZBZjJp?=
 =?utf-8?B?djN2S0NmelJzeUZEZndTRGUwcVVQeUk2Ymd1VVJySTJiL0dib25ITk5Hb1VP?=
 =?utf-8?B?UWpNbnBsOWNOR0ZhWGhTczl0Z2RlNW9LYS90b1R2eVcyZ0hpbVBQQngxem9h?=
 =?utf-8?B?STU4ZnR3QUgxVlFhZnpYb25hdXdjbUVlYWJhd3JpTlEyVVRBMGtESlNNT0lR?=
 =?utf-8?B?ek9Pc2pjeUJGeGcxNmhuRWZPeXBnMkV1Rk1VM09tRVlwdWFFdk5DZ2dkdUNT?=
 =?utf-8?B?aWEwcjlCOWZVM256NXZIK1llN0k1YWV4U1NnS3oyWE9jZmVSdFdRWGdMYnhB?=
 =?utf-8?B?WWljTzRuc3I3Q1Z4OGFGeHNld3ZEcUx1SGVWNzlQRnozS3dRL1FWbnBUWmMx?=
 =?utf-8?B?K1R3Uk1jZlN4dm5kT1IrSko2VUZuMUNzQU50MnFFdXhwekR0UnVyWHdxa25r?=
 =?utf-8?B?L2xpdytPVC90TFNTdDNFZVVzZ3V5eldlMDdpTi9pQ2xUUUF4SXQwODJiL2Ev?=
 =?utf-8?B?ZlVYU0Q0WTdEUVJJNzhSYXVZWWVtK1Q2dDcva0g3UnFCYWdxR2diaHRSd2lX?=
 =?utf-8?B?UmoxdiszNDgrUHBQaGVyVWdtQk1TWDhIL0NjY2IwazJ1OE5tdjhjRjBMTjY3?=
 =?utf-8?B?SDVLV2FsNUNhWkZYVEdUQnFJbjdxdlJjSTREdno1M1VlRTMrNTdnWXVSTFFQ?=
 =?utf-8?B?YzV3RUtiMUJVVXBOMTA3ek54WTZhWldsODRXVG9qVHR0NzNxcTY4Rkk3a2p3?=
 =?utf-8?B?S05VYkNUdVBteFcvdTlGNTh0ZTVGZmpoamwxUCtEQyt4WjBQTXY4MS9uQWlY?=
 =?utf-8?B?a2c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa80d4aa-0d7c-47dd-29fc-08dd0871b4d7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 08:11:01.6342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmmb6bWUFWQsvfEk1v0uqFqPHwB4aqLG6RhrNL1V+WtPmAmncVRhkIMr2igZMz703SVDd8g2eTW+eymPmZalQ6qimpscRf7O6B2nzkKkHMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7876

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add device type data for S32G2/S32G3 SoC.

FlexCAN module from S32G2/S32G3 is similar with i.MX SoCs, but interrupt
management is different. This initial S32G2/S32G3 SoC FlexCAN support
paves the road to address such differences.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index ac1a860986df..f0dee04800d3 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -386,6 +386,15 @@ static const struct flexcan_devtype_data fsl_lx2160a_r1_devtype_data = {
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
 };
 
+static const struct flexcan_devtype_data nxp_s32g2_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_SUPPORT_FD |
+		FLEXCAN_QUIRK_SUPPORT_ECC |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -2041,6 +2050,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,vf610-flexcan", .data = &fsl_vf610_devtype_data, },
 	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
 	{ .compatible = "fsl,lx2160ar1-flexcan", .data = &fsl_lx2160a_r1_devtype_data, },
+	{ .compatible = "nxp,s32g2-flexcan", .data = &nxp_s32g2_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
-- 
2.45.2



Return-Path: <linux-can+bounces-7276-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIVyG6LSxmkhPAUAu9opvQ
	(envelope-from <linux-can+bounces-7276-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:55:30 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5413496E7
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B00B2307261F
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 18:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BF03939B6;
	Fri, 27 Mar 2026 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gWaKFoMW"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584BB3921E3;
	Fri, 27 Mar 2026 18:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637344; cv=fail; b=ZYwGDGuAlVBRa+h6H2WHlSbvCS85QRsAc/4bfUeufyPAKxuAHM25uWfxwGXI1im6khl1RC/5fE7nhYkWzx5T4Q/kf3r3B0a9/ujTU0VvPzPREbn4CcWhFUJUHUFJ/bCWcbtNaY39nwSTKr+S/iXjGaZeCLdUcAGaG/KmOUhFr6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637344; c=relaxed/simple;
	bh=C7cOaUVzON9ngroWUFrWtpgB8waO6J4hBqrmv6KJZuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MigGZWx2V6gz64r1e6uyIRPNhRUeR9WFkeJG7oF7eXiEWnFpXKLAIgtKRf6TpqKnCnKHloNsJvtGRsc20dibvvQe6xrQITgZJlZk4B1oFp8MSl2ChKaRgwCJgaG7mPD4cKNS4IecvYsi9uByr3B+1b1laj905WcfWX+JLnSjya0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gWaKFoMW; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITI6cMxQjIP1ebFEUuJhxwLrJfq0sfnmIxmDy3Ko8n1wR8anImHxdBd0VDhlIZC1ehbx6hRoN0hbtq0d+c7WZS6uMSNo+IIRx98rpCRfEOihqaupvYAb/yGS7Is68uEMsmcMb7umlMpBDGmqFRLa3nzDIFPppcRB0ai50IDTUi9DcIrAZESyVNDuhCD7ho+0hESCrfEJS5+YnRLNqhRWgaMHyihRjiFRCcgBuo3hVTpEU4FuqP0EsKC90BWh5BnRMDk/MPI51cBnQeBGJvPTbiSOXzuu6FBntPOgzHUaqAPvlV5m2TloLgO7UAp/Ehrq+GDmQQD5P7vo+eqgyZzjdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsTp+y5bk6sSMYxYo2yqc7XPTeAdB5MbhMF29byqe8Y=;
 b=Yuz8TFWFTmyf0cPB8hTN1DvI2c3MCH3U1EmtQUzbYLx1PPYjmD7d9ng3lOuOHrNcBhiHmJ+1+vXkoryd8uhtG2ouroVdlOvkjFJt0QiBNFcztwujgitEhh97C8bGwQz2g/Em939rEod9WOFLX0N/mv1l2EfuCXCMIDPIdhWNHnJqSXvrt93GTohvKnNUzSRExvlZvRLXa52Km77FMKdNSJxecPn1zYr4SAqfbJtPz9hoVZ3rxElZ5GkkYhOm9euy8GrkKqvQaqhewVPJ0OzrdVbdyz94AwB7/ffjnSOyi15z2rS6q5h8iotdY/gr8Vi/IwVT+Dq8F1wC26f8KpPshg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsTp+y5bk6sSMYxYo2yqc7XPTeAdB5MbhMF29byqe8Y=;
 b=gWaKFoMWPz2m757r8GQBFQ5zE/hbjO/W6dnZtSdtuvGd5auswvgcQA9vMWCULMpgnhZxfGuPrs6Rlc/psKKZTU6zUb6qT+9/V0Sp+IOMcX+JcEQxB0iIJFyEuRxZWwXB5GI3bQhgxLuU8pw1khHfmm5kfoTkXRwagy6vTJfGXILTjBUsSvmh/8xH90I6+GtZbBsMnTtB38J/InVPlMTKFkKSeIjK05Q6O1fZApZrv56wla4UVcOmGuq+zs2EzHSPA48KDPKe9C0x+8o5BzqtG3RZmXc7mJjrwourHt/ki+4KFkh2QfxlmoF9Fs4NZ0oqqYbWsp+lwZMxFkwwheqVcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by MRWPR04MB11287.eurprd04.prod.outlook.com (2603:10a6:501:79::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Fri, 27 Mar
 2026 18:48:56 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:48:56 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Manivannan Sadhasivam <mani@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v6 phy-next 11/28] scsi: ufs: qcom: include missing <linux/interrupt.h>
Date: Fri, 27 Mar 2026 20:46:49 +0200
Message-ID: <20260327184706.1600329-12-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0110.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::39) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|MRWPR04MB11287:EE_
X-MS-Office365-Filtering-Correlation-Id: f0eb37d8-8fc1-4442-708b-08de8c318041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YpsvPJWWSKoHAjGzYe8Nq7JQd6CX9IPsSu1YO6XN6LZkyAxYWyeqYmoTgH4Y97RDkwo5Y1vH+ju6GhGWrBlvYGLdvel5Ad+u8fZEHtpNN6nuukol5ZwpkpirA+uOSqzyitpgr5rzAqY19JXB5CVsfIm10wtnQbWI8Z/0sHzwMt8xzMtABS07Qj2+gvTtEoBN3V8JP6UOnLP8+6xeAuuqoxI0BLO30wZuh/4pLoig58FXrowhc4a03UoEkNpEnm7lToZybcYOkmG+k5KNqa5vU2hcg9YFmq9pH58TsIZjBLTrFuWXwe8o1U59zKySyc8R+doSxzAQ9gy02JuzGf1FCBjVlDzXR7k5TJ4drl3C+3WbdR+s26gM1TS1nxnrsl5NGBrmKI74bs47Yc2xviGp6qnhPZ2wlEfJFYTB0ahl8Ka5tw4To+Jerp5uLLgFQxwG+7c4r3YrUcKOJhHJnHFpaRC/GosFgPCZTKS//jwCdbBROtncHoKY2rRt7TMoxbgVXw97ASJXGrJHUrbBzyMWBVAXP+1G5dtHuBHkMdALoxzEq+IYqY2v1+x7hUsc93QHTrB67RN4nqOwbLNzj4p2t8acmkxgKBbj+W9vqCKE+mUG3X4HtvRZNfsIba2rZnizV+Uja6XsKyfObk/4tkI2zfsJIaax/XI2cN1nuss1S8CmCeDWGr9L5KQNmcwA/oh6w8Ix+eD1r14Nh1XKSp0TVYG2XyHhbBawkiNlQRaS2q0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(19092799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NqV0oUhN3fJyKAwQLAlj9fgPIWpe2e6IMeFLtFZTpaTV5MbT6fKL7lOMH3+O?=
 =?us-ascii?Q?NsGYGGP5rnlkV9PfPOo2t0030EVygc+3o4OrQoqn8Np5PBwuAGPoWOUaWc/7?=
 =?us-ascii?Q?N+8dVIqGvjNpGnUBliHnnmm++KKhjU5s3HNjU728l18ZdcYciNu80uM4nigI?=
 =?us-ascii?Q?7b8bxhiTQ5Ab5N0BC2asIZzMqwb77Qk1ln5p3cn84JOh9jTVytVSQzfg+hMb?=
 =?us-ascii?Q?P1qpp32JYtnQKIBQXuBDATQia1zxp4dimoaN4/iDvSumVPApYyP0hXSz496g?=
 =?us-ascii?Q?k939AN+Hl2Ls5+1U+JDXW/Zno5s6g3tFxwGUyy3L7VYzYMjCRW4KESJvyclR?=
 =?us-ascii?Q?cEF7ixnXsudcc5UhbA+wMKrKcHMijBlDh1vDn4tzpL2JIxmoDsZuL+5Uv1xG?=
 =?us-ascii?Q?P12CYhz/TFRL7J7VSBx/SW6Xij0kdcKYdagWZd3qUiZNd3AM1Q/NfJcImIsI?=
 =?us-ascii?Q?iJtmjL7pkpkP0ujhufhzMMhX0SMM/AWMw4wlK5zyVa6OdBNPop0pk4dzy5Hq?=
 =?us-ascii?Q?rUddf/cVhX0DU0oLAktznZyiPXJaj0kxODjg1/gttSXOdTUQXaJVAFsCY5+w?=
 =?us-ascii?Q?q8HVi6OBFsV0nBfDFiUylWof5T6XxB1/uOqX2VeTmcFTpFx1ljEfMo7c7G3G?=
 =?us-ascii?Q?QvqOwsXLzpGO97jFdIU0GydIgeGmLY/TQuGA3QtHUtqnt9dtlKTNZfydAvPv?=
 =?us-ascii?Q?xEHVPqOa/kcZEwqVnYB1fLkKAwqyL+Le2bIya6CWfzKvQ1spWIT50uxl9A1v?=
 =?us-ascii?Q?biFUHBJWo9/Dw1+i/sJ29Okwt0zu0AJTbx0WdM19OatHOcLjuwI5uauDynrD?=
 =?us-ascii?Q?7PkP4wyj96BADdDYVy5vChNOzY+oH0Rvrj+/Kt07Q+gdvvpeT8m1ZlrbsRJ3?=
 =?us-ascii?Q?Bobx3g61fbi/fc+rwHTY40BUyYMbZ/hNGT/o3Cf4gkG+OD3WkWzh7mZD0XMT?=
 =?us-ascii?Q?zLU97MMsWrln65m6+fGIJRWkolP6H/ZWnBw86+qnFAF611uZpIwUSlX7RxC/?=
 =?us-ascii?Q?UPoFBFifUPoVlnsyoJXLoBgbHSbqmGw4eCeFVJqnDsi5jlAV3si58rLC2EFQ?=
 =?us-ascii?Q?6oVGON+4dJNGKrMo2/bzh3ie05JXwJMRnUkfzsqeCc3r3ZcM5z0C9IZ/gwUA?=
 =?us-ascii?Q?uYiiBOKYYCnNryBtHZCLO/GmUrVUDj6NuZGhip9LV4JRxB3/Ux0WLrysNpOi?=
 =?us-ascii?Q?cUWgtfPwLBRnEFAzfgGGtjAasf3FxCM1vTn6bvTAOF/FecQ4kd1gjOuesQyq?=
 =?us-ascii?Q?UIjd2OaaRrsgEpgB1XRdeQtowNQ2i/1rgb9YW5bqgA9OaPLatiyvYLNriyFn?=
 =?us-ascii?Q?0M5KPdowhyyvPNBvgqufesBiBouF/AxAduzGQo/dEWAv/IDapJPJJx82jkGX?=
 =?us-ascii?Q?MG1+4pGO5dnB25njQhkHW/Pts0HVbuA2wZddirsFoY0OYamFSrffgpm44Va2?=
 =?us-ascii?Q?NFvsGq7ZYO0MI0SpPzy9+zu6zTfhrLPQvlzBl2bZnxdROYZYP5t4RXFKZoZO?=
 =?us-ascii?Q?w7E3Npz9mMhoO9IaD8Q29AbpgkrjQsA+OHx3T0zBw0LX7ByRLi86abIrSjFh?=
 =?us-ascii?Q?fTvPxs4H+XQugd1YmHt3uqobzFY4qaVkMFnJeiDxyy/EEMguqGNr7wKBY05z?=
 =?us-ascii?Q?6arYyRlEQVm6tJyN4/OvPduY9so9m0YiNPDnr2Lg6Md8ZCPZjYw77GsxtdCF?=
 =?us-ascii?Q?K7Zz3x+MI4vimncmXkFhg73+tSwtZu1l9NiDdo9I0NMkqbSxv5GKOnpzoag1?=
 =?us-ascii?Q?rRuAl8MPnSgK+uxXyH+fjXZFa3dZtQ8VrKh8uZr/R84sk9Exknwxez0h6CMH?=
X-MS-Exchange-AntiSpam-MessageData-1: qJv25ytR5gQvmbVSv97izkhfuKE27757t/Y=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0eb37d8-8fc1-4442-708b-08de8c318041
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:48:56.7036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bsLpWsZtwJpYZgYYhipGULTW4PqoRXXrT1j3JNaZDIhY8Lx71bNI7g537NTdfOOkEOc8Ay6rnuF6fK8owm5uOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11287
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7276-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,hansenpartnership.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F5413496E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This driver uses devm_request_irq() without including <linux/interrupt.h>
by itself, which would lead to build failures if the headers providing
this transitively were to stop providing it.

On aarch64, we can see, using KCFLAGS='-H' make drivers/ufs/host/ufs-qcom.o,
that the inclusion path is:
drivers/ufs/host/ufs-qcom.c
-> include/linux/acpi.h
   -> arch/arm64/include/asm/acpi.h
      -> include/linux/efi.h
         -> include/linux/rtc.h
            -> include/linux/interrupt.h

Whereas on armv7, the situation is quite different. This architecture
has no CONFIG_ACPI symbol, and therefore on it, <linux/acpi.h> does not
include <asm/acpi.h>, and <linux/interrupt.h> is not provided that way.

It is provided, however, through this "fallback" path:

drivers/ufs/host/ufs-qcom.c
-> include/linux/phy/phy.h
   -> include/linux/regulator/consumer.h
      -> include/linux/suspend.h
         -> include/linux/swap.h
            -> include/linux/memcontrol.h
               -> include/linux/writeback.h
                  -> include/linux/interrupt.h

The point is that <linux/phy/phy.h> will stop providing
<linux/regulator/consumer.h>, and this would break the transitive
include chain on armv7.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>

v5->v6: patch is new
---
 drivers/ufs/host/ufs-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 99feabc69111..9046a87225e3 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -10,6 +10,7 @@
 #include <linux/devfreq.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interconnect.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/phy/phy.h>
-- 
2.43.0



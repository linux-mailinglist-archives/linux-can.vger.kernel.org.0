Return-Path: <linux-can+bounces-7608-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OtFKCtTA2pq4gEAu9opvQ
	(envelope-from <linux-can+bounces-7608-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 12 May 2026 18:19:55 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 440E752488A
	for <lists+linux-can@lfdr.de>; Tue, 12 May 2026 18:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98578302861A
	for <lists+linux-can@lfdr.de>; Tue, 12 May 2026 16:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B2F3C4176;
	Tue, 12 May 2026 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VrDha2St"
X-Original-To: linux-can@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55BA383327;
	Tue, 12 May 2026 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602793; cv=fail; b=mqV3J/6s/I5oA/3pBTBz19/8oJBsn247LZfB0COpcl8kdf9sIHDFrpWDnsoNehlJbKAsIFPOFNByKH85vZJnIVV28AcmUybXv0sUUWdW38Cl1f3kPu8pt4YvUkMSuszbpuwRHpYNUREuxP9IChL78EoPEXVXC9Y5J5yFkqOIyhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602793; c=relaxed/simple;
	bh=4UFk9jD595b4DNVhnlkKWHgVSkLcI6aTjoPikI2s51c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uob2jfht1GDMTASUB6ktFWY8BZtH6Q9OcrnPWkx7uIgTmM1Qf7bSFoz6KmW5M5cWU62a1scap2xUKNITVWFVFTDIKYb3LVSrKrxraPEU/N5eA2TYmh5WuQfkC+RWehujjGdIScp3fTTx1jMpgZNiE9qrYZIQK1GJYNxBgJbLYRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VrDha2St; arc=fail smtp.client-ip=52.101.56.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwOldtFjfGJkwBAnhUvT01JKdDRHuDqL1t4emwt1782Eli0eLFgHc/4aMEBEkqsveeEQumHjODSQEUT1lrYiMGnkZljzhkvQB0UArhB8/4s5nLOiW3u+H7G6NNd7yS2ky+s270SVQQ7hEMrXPeYkb+dD3DkH0jd8d19ZTL8HzE1sz2vatUBL1JHQTIBIXnJmIvcl9F6O0FMOUsQ2bM+9J35/CdWdXYWo0/I/vYKKMrP+49O3JYlvQYIs15s+O6AFIUhx/H1scijof3dC1lbT9pP4BV2S9AhsEUaa+htY4HjrC3kZ44+TIMT8DDxBGqvh+bbM0RNfbe8Ow+JvbL9hsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImBERphMlFa8RbJHdRrej0RqYLkBmZJP8h32uFksFik=;
 b=ticvQY1Kn6Nn7qREnvAPZk5GkRy+6Eazf9hA0YSubm94PnpnZ+KR8tcS/7iboz+J5AGiZ9tE/MQEpjz9uje8UlkWj/92rKrIi4FqV8IfF2B722c2z/5oeVtaPEGLphJboKMF2zeMg1dNigk7slnZaFC/Efm9hPJVnBQyhbRec/7uTB5qihHGnn/cZ+RE1NFCIkOzjsinjYYxdYi9lkSV8Pm0V69ij+nd4HF+8RAOvCzG5EBKS0de1LIt9ZMMA5BObg8pVTma3QIrjbT7vA4H6Movn+OQRW/kXOCVlRGY2yVkTV/MQZ4Rm8AdBswJzCdxp/oUfJzVOIs0URXFwgvTkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImBERphMlFa8RbJHdRrej0RqYLkBmZJP8h32uFksFik=;
 b=VrDha2St+YHaU32uTthbJAucS765JSD2p+5NS6xd47xXNfNRVFjMuZFHQ27OnCv5nd72jMaA4vPQ2rcsMEgWGZ5r3/BKYNxaPUf6Ii8chBxlEtkj3k/5sqlGEe3gCcLBUPw/ZyVFc+Re/3CJgYPE2Fk4DFbyxRUcaHMo2TA/9DE=
Received: from MN2PR14CA0003.namprd14.prod.outlook.com (2603:10b6:208:23e::8)
 by CO6PR10MB5790.namprd10.prod.outlook.com (2603:10b6:303:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 16:19:43 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::7) by MN2PR14CA0003.outlook.office365.com
 (2603:10b6:208:23e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 16:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 16:19:41 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 11:19:41 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 11:19:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 12 May 2026 11:19:41 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64CGJfYg1806399;
	Tue, 12 May 2026 11:19:41 -0500
Date: Tue, 12 May 2026 11:19:40 -0500
From: Kendall Willis <k-willis@ti.com>
To: <phucduc.bui@gmail.com>
CC: <msp@baylibre.com>, <mkl@pengutronix.de>, <mailhol@kernel.org>,
	<linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] can: m_can: Use of_property_present() for
 wakeup-source
Message-ID: <20260512161940.4dojzctiwybny5cf@uda0506412>
References: <20260512102518.25471-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260512102518.25471-1-phucduc.bui@gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|CO6PR10MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 784c5519-f36a-45ee-4de0-08deb04245c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mp5EEdvY5jDZgaNwMNNzCxRt9YcLRe3cN41T4/y48OqRdLSztvbX02wZYi+QgTI6zTZwrbavgNBd99xeXzUp8iEuivii+r6zP3qStLobtP2+tBpjteDSzz+8visdSaqTs2IdLRj384LEQvII2RffrMIowBCD73/OYl+vg1vveyy+d8U2Wrs8jVxOR2nrl0FpY0QXLA7DISy5pE1Rhh/nbO3zP6QYA9B14lg+baeuOR+ai46SUAmuzkICP+rVCqmRj2Ah30tOs/FRlfNd6da2WLUpBoO7tZK4OYeL4LML5Ys0lSMBVg0BETf7M9EcZbhO8QpJAQVVoWyCfMO9G/8i6xD6wJaItXhMCGcgKvVKlqWEI6RmQJt5VvPrZBzimW3aUD+HV9cJPzUpdsYmbVftmK+H4Hd7z+9fIvFXMlTow7h32be15A0BdgnFzDbOlGUzzbeTs3RrpERe+f2nDAeA333MXMEXWz5kzioUZXErm7YXfh7+ucTQgHSggwWfNAAazuwzqUT+Ohx5mUhmI7sQbLV8R0uvc0INq2miJJAm8aPnYuHFq9i0nESmx3Oi6OeNZdf3oR5fLmJKQOecSlWt8URl2m4iDWMsx/I/HZi6fJZ4KUV3DBvENxlpzwxJ8LthSEUvcAPWu+0L2GQRjHf+M0bmm8oZtoxs5jqiH2tJ5Ma1e77SKGmp33BDS9Q/23YbrEtvF/QJoU7hO7pQVpL0GECIxqjH2DXJaVuO0mXcjTE=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sEu949lrEgiL3NNM7xvvZu5T05JKer9eFX7Hm4uDhNT6tE6yf+EWKOW5h8324jaeoFDAYKX3KB3MdMXIsNnUTSXZFeBOuJWGl+XccvWmGcTIgOZIFZQcs5k7lAL8JElKxB+cOy34jI+f4vxDpdgy02N1TMEGn81BTvnLYXK8VOPtBfSmagy84MFFEkqNA8aZ0xGY4OpFHCytRF3wgZMJPtVMQYil8X/lhd8qAqdE/x+U+jmwjxmjuWCjClxZfpP5yPm3eTFSXPo2JFgIF2585AJ0RRfwGtf6NnKV6leVsd5JMxKsL60iQm5vy6+9up+NxDS/ZdXwEi//L1VRrNEnBPpmo1dws80MlBrCSosfXcAYo2YbuadtrXuYo1aEmFEi023AESBTM+zNYQYH6gDfCem1j+YwyvICRvQxrvRhn5ApGFGs0JzzG3v9K8M38dAo
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:19:41.6921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 784c5519-f36a-45ee-4de0-08deb04245c6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5790
X-Rspamd-Queue-Id: 440E752488A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7608-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[k-willis@ti.com,linux-can@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 17:25-20260512, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> The 'wakeup-source' property is declared as a phandle-array in both YAML
> bindings and Device Tree source files. However, the driver currently
> uses of_property_read_bool() to check for its existence.
> 
> According to the function's documentation, usage on non-boolean property
> types is deprecated. Switch to of_property_present() to comply with the
> recommended API for checking the presence of a property.
> 
> Fixes: 04d5826b074e ("can: m_can: Map WoL to device_set_wakeup_enable")
> Acked-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Reviewed-by: Kendall Willis <k-willis@ti.com>

> ---
> 
> Changes in v2:
>  - Add Acked-by tag
>  - Add Fixes tag
> 
>  drivers/net/can/m_can/m_can.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index eb856547ae7d..16f80607e150 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2464,7 +2464,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
>  		return ERR_PTR(ret);
>  	}
>  
> -	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
> +	if (dev->of_node && of_property_present(dev->of_node, "wakeup-source"))
>  		device_set_wakeup_capable(dev, true);
>  
>  	/* Get TX FIFO size
> -- 
> 2.43.0
> 


Return-Path: <linux-can+bounces-7574-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOiGNrCK/WnWfgAAu9opvQ
	(envelope-from <linux-can+bounces-7574-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:03:12 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5F74F2BFA
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C6EB3016CC6
	for <lists+linux-can@lfdr.de>; Fri,  8 May 2026 07:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC943806C2;
	Fri,  8 May 2026 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="J+jJ+cnt"
X-Original-To: linux-can@vger.kernel.org
Received: from GV3P280CU013.outbound.protection.outlook.com (mail-swedencentralazon11020110.outbound.protection.outlook.com [52.101.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB2D355F2D;
	Fri,  8 May 2026 07:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.75.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223720; cv=fail; b=jMr1a0VEC1BnwBts80pQDxXMjpuY7MYRA+ppchnoVLYfVO5NU7UxwvKFkPhrMfYmzF/zk9PS3aPsFMjJ2qs0E5192tL0d12BqlPTFtVOZfVHlSaMnso04knd914D/k9mfbSZVGiCG9lgLVGHLG8iuECdwHiTJUtbpUVJEgvRv78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223720; c=relaxed/simple;
	bh=bgxiL2CenjSgTX8ZyWNi0qXCIeEd1o7ChPjVwhCLiCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YwieXXRmrExHp/y39c5V85f/G21Ps4x9zCic6lBdesXDv2//L+/CNuiBfo2jlYQFjtCnH8pi7XdHZ13EUkL4FxaKO6kJ3UpeXumtNZes0n4REg6BbJOdU6ZgFBadkcigjsFiPToMKOL3JC8L7RWQmsxT9NAj10rqmUdrrqci6jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=J+jJ+cnt; arc=fail smtp.client-ip=52.101.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxaqeMfQtp1g6AVGgeesOr83vBoaJ1OX6I1yXJZ5ukySbomiWPZj+wbE20dtt321hYTRC/BKCcoetCpX1gujS86MMnt2iacWe9rKYkY9VHCblCHQa5iYTLSlKFDVbtEqKo+iuCACdno5gHWxBOIkW6FPFl3KkJrG8DWP1F7D8Ejzp1Vy+CGcz09JAvyjtb3KfAAt+0LIVHkieibY/eknOgbiW3/NhtxyYp684917wj6I8fqmH21KkXv8pEq/k6jN2O1ZmHfa2gSa+1XI8DNXGsE9SssR81ot6Mjygc73J8Bt0XiD7EQ7YuDx58pVC31HqdJJyGL/IRYlXg4GbnkXMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKdKbsysS8VkeCXJuVcT399Xxcd+y14MQjnvsfRAtQA=;
 b=ypfgrcFTm/Sz+yd31NeZBTxTBdAVoWHdpKDXmT4L8n7Q3jEhrMn83NCa0cSzXm4Jd7bNUbRYnspHpUrP4SkLvfHjCq1dKbfiiplaZp5yA8/A+EoVX7MY5AMy2Xkt+mEeb4AN9qANCDXpyaB35xxgOvQ39QU8JFGI3XiuU2Hcy+5b80HKOdHlRhfE3DU6j88YQa1rgJ2san5NMZayxe1UCcMYP7WLmIPz+1SuGTaoGbWxxyUIsvKKN6AoJLPqqmP4IRiXod1U8zvBXWh3Hvz2c5zNGhGYPgK5e1ZVgHuBND1huPuCMW9SwoJm/1KrjST0KiY/+6qcpTyEWHOj2RHmow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKdKbsysS8VkeCXJuVcT399Xxcd+y14MQjnvsfRAtQA=;
 b=J+jJ+cntnm4bzQ26BNH3W1WD0KKlqB+k2RrSB5IVp64JsIGZDzhG8pg98rkLTgGFMK7PYiBvSrBWUcUrt8nBY21feff0fO7MQ7eP0QgZo90xQLo3oFwVVHc/udZrimbFZ3A/xsX5R57q6n31X7qsLELr53xJ2AhYmLE8gpyXUgxATV6nWm6Js1/4UyvG4A8OAED8nn54E9dGOa6xaIez0v8zTzXeBl0GeoT8JIWRe1oLw6zkbpeT6jOLUENTb0IHDonrKXFTEIrBOh7biwn9zAzRAets6dsJ17OiveeEg20MLBFhJpeLvWT96OnK2Xwxvj+gLEd8fhLZ1pMwLLAAdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:188::6)
 by GVYP280MB1876.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:01:33 +0000
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e]) by GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e%6]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 07:01:33 +0000
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v7 02/15] dt-bindings: net: can: gaisler,grcan: Convert to DT schema
Date: Fri,  8 May 2026 09:01:08 +0200
Message-ID: <20260508070121.6918-3-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260508070121.6918-1-arun.muthusamy@gaisler.com>
References: <20260508070121.6918-1-arun.muthusamy@gaisler.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00023A0B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::212) To GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:188::6)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV3P280MB1530:EE_|GVYP280MB1876:EE_
X-MS-Office365-Filtering-Correlation-Id: 3961909b-4810-420a-c88c-08deaccfa35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3NHA4MqJmvVqHG5m8b3IGq5TQCsHqmHCE8VQzhouNo3HEtk0jqxBPtdW2Ynu4J9/s9OMVoT78q5vGu1iaamJFhMa/3Mhs4pUcCe6nKDyV6MFPUMRKcsTxBIAdMiviUq6c1RXffjSofr9VO3sAKbhTSlMhNo2QmbeseogTKg2e4HnKqBqvKh5O9Ois1jMXXTSF5mksOg2nrq1qQ+lojNZQ2PqneAaDWG5o0ACHGuZjHABhi+bFHc4aseBROvc9nnpOfq2IZJsCAnO3s7yFQ5p0Kc5qWqfdV0IV8qE6xNqHbGMdvwfyvDbRvR6l8am9+ppyOMMj4YyetsDwsCRxlhJVTlHKhpeqBl4oXcM2iqFdkRX4ffEJna2lLn2dkYYvSVwG3dmJpJlSlsQuZ0el3kiWHAxSBmoAg6wooJzQYjkOCmKdpqmL+buDh2mIRFobYTEFqRCFxuBG0bnsxRKT97S5JXHBu5Y41ttYP6X6qT6Dmpx7xGCWqV5ael/1+ZQh9FB4z2NHh68tpC2AkiYze1v7iuCRaXWMJbnaFStqnladKp2AivkDjd9/dqBjCBnpPpPL0pmhoVZYjZ7xErKoUO9jYO2S560YCynfHturQsk/IIMOmGvkk73vD3KN0srSEJE/10qYlSzgL6wXgfh34ondOu3F8jTtgD5K4NGCxQXScUSC4xPJZeU2sOwjZrp+RcSJoL5iq4zlMMJ7UNKVK20KQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oKiYHdYQM5qn2Ydq+NH61D0fBLDnpIFyiOLAOkAaNv4lzxHI8ebI5qSRHMdh?=
 =?us-ascii?Q?2CDJz+CGci0hs7UsyufE6/j17LeyxnkpZrEgpqfAnivMPo/C4H8P5Gw1s0p5?=
 =?us-ascii?Q?fkwNRB1OBP+1XjiFwjCFXyp5hfuW9hI6RkzzfAmqa703Git5ElEaKZtaJpP4?=
 =?us-ascii?Q?Z6fUDR5CfAZDOaUSJuro3zEjOkchsxKLdQCSa6MlJ3wndo8yoalGmke9PRj3?=
 =?us-ascii?Q?OSa/28Z6fbgSoBCdky3jN35dQUxdDG/j3oggblM2z/dr6syUKcUYbFHlRE57?=
 =?us-ascii?Q?V4I8nbanXgSPbdRHSfRcoRgtj4WEQQq19imS5yk6XspIkH+PWgcIWWgoU1HU?=
 =?us-ascii?Q?uJDS/SEKGoogb76gEeZ9eSlB8gsRyK3Oip/nvWF5BdLySzQd6qnO+tyMZBw1?=
 =?us-ascii?Q?2A6Cql/LtjlPsbCHbvL9jR+Vm7yGpcgzE4B2PWLEnFWg9w8jEs/2typdnhTD?=
 =?us-ascii?Q?qppvrh5BdKvBMq5o2/uLcPdOx//9qA/XBfVbAix5TVcHS+qN3AXfKojKRHbP?=
 =?us-ascii?Q?I9MTwl91heCxQ/qCk5H3jVQ3M0uETcNeOJwsjKl9D3Qg+yM+evPZwA/HEONX?=
 =?us-ascii?Q?TZqJ1XrxpgHppQQi6+16vuDyVDLxCl0djjiWo7mpZgBNQQXRwhjE3uJ2mLBW?=
 =?us-ascii?Q?pSnmpfqWU1VhuZriEdWi+rfFedZFfqR6NXaXqViwf+Y/Nuc/GFsasJv54mI2?=
 =?us-ascii?Q?Z3gpxyMgUmhmYO40KPSDqJoT9c7UJc2lHR3atpsrOP29m9ndrtlI5R3RLmUJ?=
 =?us-ascii?Q?kBK2QRqQOw6HLvGSwOFGNAyBfNSD91cb6RL4xfBRW8yaE4WfMmmYm1AByqvu?=
 =?us-ascii?Q?zr7B13uqFB1ohNSa2OtSh0Ril4aN5fDcdL/9ycB4c4miGCEkqNcQ3tIjLWVN?=
 =?us-ascii?Q?iwmzmNh+FRcDh7HN8WCqoFYxnlpeSOflmNer31yOUgFSmRaScG309xB0yRCb?=
 =?us-ascii?Q?SyWz7gMZKx+JxrfbOggNwS0wyOZVA0DwX/ewk7C2SHgrbZbIH0y/lAKr3JcB?=
 =?us-ascii?Q?n8T0hhDCok27Z+dN5Oxk+XrpzXG0xfHbp9UGIGuG81wLC6LLz2V0cuW3jENB?=
 =?us-ascii?Q?ZtoyB4wzbE1YPLUfL2pgewO/nNcliG6/63xUCsXkLgSeKSCJIei0zvxg++1F?=
 =?us-ascii?Q?P63uKdGDcwgYaY6pDd3O3se14wZX4UxHUeHJQmxbSpiDd/tzqaOzy/urwiXY?=
 =?us-ascii?Q?RHwhG1WB5HwVLnR82jNz2B36nCpvaQUIqI0ELr1uoejkg+O9xXbmvIMzRtse?=
 =?us-ascii?Q?vxnbu/BvLx5xluhBU9/sIjlrWQUTOEMEVzV3LjOmTbffLEL1T/M5X74rrAQt?=
 =?us-ascii?Q?VK6UpD2bbHf2pNNFpwWlTFpp0+taazwX2uWir9+QU3R9YUh1/ouf9ZKI+Xnc?=
 =?us-ascii?Q?2plKDtpa5uOmjj7kWE6mIqoyh7ZEGZcQXkzAJNA0FtoKbG9ZEOQRnVmq0Ff/?=
 =?us-ascii?Q?bDyo6tNlESViTIuqIzIuRVAo90Nev0Tp/k0f27WOrJWk4GWrksYr66oJjz3/?=
 =?us-ascii?Q?9BzX8eWhkin11Pe8CxevgRnBLyUKkNuO0zXL3LNafeQzfAL3nzoWLyd7dS8Q?=
 =?us-ascii?Q?3gJKwd/fWK3u+cVxdybVS+Fr4ovzc+ObSMckPq/mgb4W5inAK2hfsJ+Tfr6t?=
 =?us-ascii?Q?dOAIt6GrBVdAfg9QTPvGjRMJF3DyZK/rbKbjKSbbFYXx96PXeLFFde8+49XZ?=
 =?us-ascii?Q?EltLXugxODzs7ePzywjQ96tcepCwj1fPNWZObpJ8CkDYDrniBXTrzYsDwtmh?=
 =?us-ascii?Q?n8eg1ZNIGbiP2A0OvjFvGXzULsCqSik=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3961909b-4810-420a-c88c-08deaccfa35c
X-MS-Exchange-CrossTenant-AuthSource: GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:01:33.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rv9U1cfcGXHvMGdAkfP7BaTo6peUwi19pmkeHwym7HapuEfvgdAbSea14TI9EqO0GULER3Rp3GGEkdUqxWJowmzPEc0Xowhy2vuPkfSz8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB1876
X-Rspamd-Queue-Id: 9B5F74F2BFA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gaisler.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gaisler.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7574-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gaisler.com:email,gaisler.com:mid,gaisler.com:url,gaisler.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,devicetree.org:url]
X-Rspamd-Action: no action

Migrate device tree bindings for Gaisler GRCAN, GRHCAN
and GRCANFD CAN controllers from a text format to YAML format.

Additional changes:
  - Remove stale systemid property
    removed in commit 1e93ed26acf0 ("can: grcan: grcan_probe():
    fix broken system id check for errata workaround needs")
  - Make freq optional
  - Add clocks
  - Add compatible
  - Add example

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 .../bindings/net/can/gaisler,grcan.yaml       | 62 +++++++++++++++++++
 .../devicetree/bindings/net/can/grcan.txt     | 28 ---------
 2 files changed, 62 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/grcan.txt

diff --git a/Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml b/Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
new file mode 100644
index 000000000000..8fea97c7319a
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/gaisler,grcan.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aeroflex Gaisler GRCAN, GRHCAN and GRCANFD CAN controllers.
+
+description: |
+  GRCAN, GRCANFD, GRHCAN controllers are available in the GRLIB VHDL
+  IP core library.
+  For further information look in the documentation for the GRLIB IP library:
+  https://download.gaisler.com/products/GRLIB/doc/grip.pdf
+
+maintainers:
+  - Arun Muthusamy <arun.muthusamy@gaisler.com>
+  - Andreas Larsson <andreas@gaisler.com>
+
+allOf:
+  - $ref: can-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - gaisler,grcan
+      - gaisler,grcanfd
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Frequency of the external oscillator clock in Hz (the frequency of the
+      AMBA bus in the ordinary case).
+      This property should be used by systems where the common clock
+      framework is not supported.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    can@ff400000 {
+        compatible = "gaisler,grcanfd";
+        clocks = <&sysclock>;
+        reg = <0xff400000 0x400>;
+        interrupt-parent = <&plic0>;
+        interrupts = <6>;
+    };
diff --git a/Documentation/devicetree/bindings/net/can/grcan.txt b/Documentation/devicetree/bindings/net/can/grcan.txt
deleted file mode 100644
index 34ef3498f887..000000000000
--- a/Documentation/devicetree/bindings/net/can/grcan.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Aeroflex Gaisler GRCAN and GRHCAN CAN controllers.
-
-The GRCAN and CRHCAN CAN controllers are available in the GRLIB VHDL IP core
-library.
-
-Note: These properties are built from the AMBA plug&play in a Leon SPARC system
-(the ordinary environment for GRCAN and GRHCAN). There are no dts files for
-sparc.
-
-Required properties:
-
-- name : Should be "GAISLER_GRCAN", "01_03d", "GAISLER_GRHCAN" or "01_034"
-
-- reg : Address and length of the register set for the device
-
-- freq : Frequency of the external oscillator clock in Hz (the frequency of
-	the amba bus in the ordinary case)
-
-- interrupts : Interrupt number for this device
-
-Optional properties:
-
-- systemid : If not present or if the value of the least significant 16 bits
-	of this 32-bit property is smaller than GRCAN_TXBUG_SAFE_GRLIB_VERSION
-	a bug workaround is activated.
-
-For further information look in the documentation for the GLIB IP core library:
-http://www.gaisler.com/products/grlib/grip.pdf
-- 
2.51.0



Return-Path: <linux-can+bounces-7572-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADnaI5OK/WnWfgAAu9opvQ
	(envelope-from <linux-can+bounces-7572-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:02:43 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB574F2BC0
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A212230144F2
	for <lists+linux-can@lfdr.de>; Fri,  8 May 2026 07:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2A937EFE7;
	Fri,  8 May 2026 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="YJeinS9x"
X-Original-To: linux-can@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021092.outbound.protection.outlook.com [52.101.76.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B6834CFD0;
	Fri,  8 May 2026 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223716; cv=fail; b=qWLqxZpqI9Trt7DfozdoiF5Nkewejw0D+dfbkg7cV8mb4rXltWf6oy0C97SAtuH+0+j50Vxiobdwqyq49kDD8bhHFsthCDo97giVFFE30vv7X15vHhHKynT12sCJeb0Xm2TRN0FNNCFBWg8zEmw1e4xIq5Rre36F+ZvUXJJQa90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223716; c=relaxed/simple;
	bh=fiyZ9WDdUUK9w0iQsAFL7WSxh4bkj+tgZTmyhIzTWw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aIMcOp2lYqXeysOKz9CcaqcDbwbZcNbNB5n2aBCZBEXQ/iEBmtbCIRuq2hBMgbMR7noesm875fAwlTkc5P1f3NwVnIJcS+lUdpCb0aNHQPwbwWvEhhx67sKEui2dTruDx/j6NKZvB32jaKmOrFpz7NlnUC4wO0z9BgCzqWx3+wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=YJeinS9x; arc=fail smtp.client-ip=52.101.76.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bK9wXG4jcidxRc+gOPW5/du9okOJa2r2GBsuh1xVSaMrC79F9NTy5drr7p3ZfdDx3YmY2d1ZREFnoxKT8OgELugmaR4xlfW1mGjc5Z/uqS3Zd9g2vLWbRdnoLjm2L1u2rx973BGKv+YRausW5Ih2Xiaq0p9EmJn/InSqD9F/uYeakHmW9oGpyBYjDtXnpnokUfqpCYdvvR1uJle+rPxxRFg5w1VHnFqv4yJnJKjP3mPL7AAez9X8f5r5vZCRxKrRoCyVIfRg8pQuIlN+xFDZGzIvucImepepMnyRuWgu5yoOIMlffhdXTqZDmdyUDUey+0XhlbSf7OnMNW7r4mFxdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Vxflx08YBJ7pIfyfW2fUAN4CLE1+E38zUAj7s/cvsI=;
 b=roVnfKZoobpYZ1SGXBTA2kdlUcrcJcc4r9x6jp/3g2TQmMEWo7/V43dZ+a67J7jGZtnV5SYLDO3zV9yOMJQwTRxY7H78T6h4IVF1dV1fA3w7AAeurL/CreJCk1y7ohXUWkDtSl3fBlFpe13vHurSlE9pDTrGO8fm/ZFYsV60F4P2ROV6TLvebjVN0y8esfbH+0M8Yo8D2iXYDQMGebxupYxJ7dOZBqZ5CzER5untb5PLuRM5iqxcvwAG50JHdkIMRRv6m9sZbRUcTg3yIskE4ZJ02y2jFqKz/Qkc/EAW4LYqid2ys+mvmFX//MPn61j3Q/y0cP4Vxsl1jORnYu29Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Vxflx08YBJ7pIfyfW2fUAN4CLE1+E38zUAj7s/cvsI=;
 b=YJeinS9xVMOsSCyq4bXh1JddRKYL5SKKZbtBf5JVwTyWos0S25ccYFoxzaGuh6T74lmywII91zVhfaq74xfFPPQAPMli+eWzeSQ/lLwvP5pK/7dEo3DYQvy6OmyMzgyae81rVfL1zw8fkawBJHQErdGUKD691Ewqw4crqWW0IZqX7jVtu+LozLb+Plx85Di6hNrzk98vqcw9d3WHDrl4983BYiVq6j3xjimJuNfmiPwVErq45pb+RXGSgfm0FluXlYrsz+mLWCD7do0PIaXExQZFoLNgRRw1za1ZOxrOOeD3vkR4VSQQRme5gtOO/KIw6z6BlYO9imoyRjiTzty9PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:188::6)
 by GVYP280MB0889.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:01:37 +0000
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e]) by GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e%6]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 07:01:37 +0000
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
Subject: [PATCH v7 11/15] can: grcan: Refactor GRCAN DMA buffer to use structured memory layout
Date: Fri,  8 May 2026 09:01:17 +0200
Message-ID: <20260508070121.6918-12-arun.muthusamy@gaisler.com>
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
X-MS-TrafficTypeDiagnostic: GV3P280MB1530:EE_|GVYP280MB0889:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b389005-fb82-4d00-4465-08deaccfa586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014|3023799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2Uo5gB4+7XbMi35sqthfb7Neih5W/JFSR35kYRVjFkoZjh+E5/4dxzAL0vuZs+BkUPiiojSuvr5+dR4ByxPqykm9C1R1F6syHQ1DrXmny704CH0CERK7LcHBZxkaXZvN0bJ2T4Rsw6sQ5sBwf89xqf2tQrkNo+iBhH6w2VuxE9JotYjFYczGX7KU0crOyhXVz5xt4hcuGkBk2RjfYgDBICZgPnJpZAsXWXJXEgPUhvwxAHGhoKCI6LIFvsm5sTI9pYKQJJ84WrbKvKgddKkZxlYWo6rtRnDa2QvNEzB2f8COn+a5FFF1XhOuaFrCMjDxTr/pdfqqHfBjRj3d94l97qjDIBaxDV5eCHBe3J/xHNJJRJWEbiB5M5iuYwpAs5UrczsAdW48qgu63VJpzZSsG/d91E4dsNcEymX5Tlfm9akj3GiWErsCFasKTvanxP/2JKZw7j4XgeXiv57uNKsOc7vAw5lIlu/3OxVToEeMAKHI5SeoJUGbIne/WYDXO+fcLA4D8YggpjWYdSHJrwIsjhoEW3ptoncSRb/7HV4BevXONz+NyiLehO+v3EWZvviVcqaS+LLOIr/8Sy9Y2vGfHLD919y40dMGLZraRXEOaCozQGUk+B+XqBLHXVueWsEyM1pkFub+81f2gxgFWMSlRq4TM5lavlwl2z3zR6h0IQ0Pr6KPf71YtJmBqmBBxCw9SExaah/4Imos1BOfq8LvTyp/C3W1WoH2XYdGOJ0Cc25LQ2ZeTr0KmgcorWetj53S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014)(3023799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yNy5Mh343d9TT5cmCWf45SijgQze/ozQwtNcjfeRMiAAZPZXmMoKAv46HMGb?=
 =?us-ascii?Q?H7JzGWPdAwbcatXblkLBFIVf3GmiX2cF5Q+iJQXp9GoCSOnHIFMtDSxBSZQc?=
 =?us-ascii?Q?QHgeXZLMQNod03+1jt/LtBFCK25c4ubE44SLH4JzUSaYAIs0RWS2/iA5jNr1?=
 =?us-ascii?Q?a2vmu746+WesZvMBto5Wv7ur6DrK40Fvg50CkN+ED++xr4cyGdxg3lqovJYX?=
 =?us-ascii?Q?tdez0GFjqfTw7QSiqrU1hS9PHiz507sh7IMn58JL/DympCg6o5G6OOgOVl1q?=
 =?us-ascii?Q?X6Mvbi9HPwUZVGvsbcXzfnCJdpMfiiknQE1A47swUQFA8mvDGkqP7ofAFrcH?=
 =?us-ascii?Q?oEttkcwOC6Nzb1f9rhTtHoEjGf91vIOSUM3vJ5CaR83+R99fgPAhfeXxpt1K?=
 =?us-ascii?Q?8isKjysbvDHQNHruol9CRd/9AD5oZP80uKdWZBk+q9JOjC4sFsQ01C61c9PD?=
 =?us-ascii?Q?vFZeSI8IDTeqyTU6KWsAAYdhgHWv4k3RhwLmbaKPBOh7kHSrHT2QpJ9Sainx?=
 =?us-ascii?Q?36z9zq+aNjv0d4EvtN8L0TDYHTq0rY6/X5Ozujk5coti2hlsEOZWdWbFA2OT?=
 =?us-ascii?Q?Cjf8HsgpenlNJly/kXC8eAjuuIUpnfQAAmh9XPT2SFeaZRSUzFgESGPdO1kH?=
 =?us-ascii?Q?b9Z6LXTaF5VR465rKi4VmjMJPYfitpl0bIFccqUzwcL/XxwWlJ2nx99F0tS3?=
 =?us-ascii?Q?DIB08L0APcG23CiS1aO2ss+NrTusCjlDijDYg5Ik9LDfMJcO8UVYzt55BuP+?=
 =?us-ascii?Q?LDQCFEyj8sCuBqk2wcyo0qc1q7oDIMi0eHrYEN7PH57uU7BA40aa61iIZPkO?=
 =?us-ascii?Q?BUpYKK12Kj/zRBQF1npby2tJdHphAA0LAJk6ykc0FCUUQYd+w5jpbf9TLAWR?=
 =?us-ascii?Q?+pAx5fvHVDvs9UqFDXUzY5yWVnJnYECrv2mWbH3oRbYcrwRMkC3DckXeOFE8?=
 =?us-ascii?Q?naBcK2pTA++3s9R1Q62lMe+pyywOF72dQb+TlCj2sK5oE3b60Ld3DafcNk/M?=
 =?us-ascii?Q?ShwckvUiLNzWMdqroF2Hq2zZ7CBOuiSh7dsT8dNI02kPM0nq01CWrqyCnFSD?=
 =?us-ascii?Q?c/coP2rc+pEaD7tbnpOkF7L4KqsVLbuLvbhgB7arbkj/vkU4fQEw9inyQcsT?=
 =?us-ascii?Q?bLbKDZbEum51dikHMyhWCMBZU/j58JIfDhmGV+BzaAJq9QaMkIUtAEOEwmbw?=
 =?us-ascii?Q?czj3zTxdxlw6S7s1m1PJttwwLIZLYvL8iVhXn3hDrSNwKYUHhUhYb8gxva/G?=
 =?us-ascii?Q?Hec4YsEmDevyvVlC1t3EsCCF84SLc8yA7KPSOJs0eID1ilLM3+VIs5Sxhnrt?=
 =?us-ascii?Q?JmNk326gZbYf/22da8nFVBhycofu/7FdNv6STJcxXKswa3CFiok/S+ednkZg?=
 =?us-ascii?Q?22q8SIC7aCb3bUdxFJi94WwU+McOFmWcR9MrbyFuklDCaIwUSbMmxRzBWTNu?=
 =?us-ascii?Q?6VTzZXn+0qvtzawzTPCOvNQ0ZscrymelILj28UtZW40TKJaLakkRRf/wrWZi?=
 =?us-ascii?Q?uvai50B+moPc+sh9op8mf0dneGx0FGxH4/E9I0TT5aaaTAsJSS8ycv9vGF3S?=
 =?us-ascii?Q?cTRY4T7cDKFuElb+39+AyEHJj+PhcDlUoBIiKU3xiesoyTWodOV5w3olODRK?=
 =?us-ascii?Q?ZedCIEf3NFeZAXHIZeBLrTVJsdTCQUQgoyATcfOyiLtMLLkFmO97Ka6F044/?=
 =?us-ascii?Q?5ubi5d+p9SYw625s1FtYDG2odKW4MgUkoZmFYLDJ3l6BZJMKJtVi3GpVgPSz?=
 =?us-ascii?Q?PYFEQjbEeG4f1aKr9l+yMGXSnIFxebw=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b389005-fb82-4d00-4465-08deaccfa586
X-MS-Exchange-CrossTenant-AuthSource: GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:01:36.9383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 202xxrDUESumGR6dbn94+RBaKYZtnKceXnNQxgQi0+pIiRRehGpOcAcY2vajVcWKyUP5Zsih28dhBJ1TVp4wZDlnqwqHAAamh25ZDysmESk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB0889
X-Rspamd-Queue-Id: 3BB574F2BC0
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
	TAGGED_FROM(0.00)[bounces-7572-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gaisler.com:email,gaisler.com:mid,gaisler.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

- Introduce a structured layout to represent hardware memory using
  struct grcan_msg_header and struct grcan_msg_fragment.
- Updated the GRCAN receive and transmit functions to utilize this
  new structured approach.
- Implemented helper functions grcan_msg_header_at for accessing
  header structures within DMA buffers.
- Replaced array and bitwise operations with memcpy for copying
  between CAN frames and header structures.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 80 +++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 31 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index b5527fd9e02e..4921da349a0e 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -195,9 +195,6 @@ struct grcan_registers {
 #define GRCAN_MSG_OFF		0x00000002
 #define GRCAN_MSG_PASS		0x00000001
 
-#define GRCAN_MSG_DATA_SLOT_INDEX(i) (2 + (i) / 4)
-#define GRCAN_MSG_DATA_SHIFT(i) ((3 - (i) % 4) * 8)
-
 #define GRCAN_BUFFER_ALIGNMENT		1024
 #define GRCAN_DEFAULT_BUFFER_SIZE	1024
 #define GRCAN_VALID_TR_SIZE_MASK	0x001fffc0
@@ -242,9 +239,23 @@ struct grcan_hwcap {
 	bool fd;
 };
 
+struct grcan_msg_header {
+	u32 id;
+	u32 ctrl;
+	u8 data[CAN_MAX_DLEN];
+} __packed;
+
+struct grcan_msg_fragment {
+	u8 data[GRCAN_MSG_SIZE];
+} __packed;
+
 struct grcan_dma_buffer {
 	size_t size;
 	void *buf;
+	union {
+		struct grcan_msg_header *header;
+		struct grcan_msg_fragment *frag;
+	};
 	dma_addr_t handle;
 };
 
@@ -417,6 +428,12 @@ static inline u32 grcan_txspace(size_t txsize, u32 txwr, u32 eskbp)
 	return slots - used;
 }
 
+static inline struct grcan_msg_header *
+grcan_msg_header_at(struct grcan_dma_buffer *dbuf, u32 offset)
+{
+	return (struct grcan_msg_header *)((u8 *)dbuf->buf + offset);
+}
+
 /* Configuration parameters that can be set via module parameters */
 static struct grcan_device_config grcan_module_config =
 	GRCAN_DEFAULT_DEVICE_CONFIG;
@@ -1215,11 +1232,11 @@ static int grcan_receive(struct net_device *dev, int budget)
 	struct grcan_registers __iomem *regs = priv->regs;
 	struct grcan_dma *dma = &priv->dma;
 	struct net_device_stats *stats = &dev->stats;
+	struct grcan_msg_header *hdr;
 	struct can_frame *cf;
 	struct sk_buff *skb;
 	u32 wr, rd, startrd;
-	u32 *slot;
-	u32 i, rtr, eff, j, shift;
+	u32 rtr, eff;
 	int work_done = 0;
 
 	rd = grcan_read_reg(&regs->rxrd);
@@ -1239,30 +1256,33 @@ static int grcan_receive(struct net_device *dev, int budget)
 			continue;
 		}
 
-		slot = dma->rx.buf + rd;
-		eff = slot[0] & GRCAN_MSG_IDE;
-		rtr = slot[0] & GRCAN_MSG_RTR;
+		hdr = grcan_msg_header_at(&dma->rx, rd);
+
+		eff = hdr->id & GRCAN_MSG_IDE;
+		rtr = hdr->id & GRCAN_MSG_RTR;
+
 		if (eff) {
-			cf->can_id = ((slot[0] & GRCAN_MSG_EID)
+			cf->can_id = ((hdr->id & GRCAN_MSG_EID)
 				      >> GRCAN_MSG_EID_BIT);
 			cf->can_id |= CAN_EFF_FLAG;
 		} else {
-			cf->can_id = ((slot[0] & GRCAN_MSG_BID)
+			cf->can_id = ((hdr->id & GRCAN_MSG_BID)
 				      >> GRCAN_MSG_BID_BIT);
 		}
-		cf->len = can_cc_dlc2len((slot[1] & GRCAN_MSG_DLC)
-					  >> GRCAN_MSG_DLC_BIT);
+
+		cf->len = can_cc_dlc2len((hdr->ctrl & GRCAN_MSG_DLC)
+					 >> GRCAN_MSG_DLC_BIT);
+
 		if (rtr) {
 			cf->can_id |= CAN_RTR_FLAG;
 		} else {
-			for (i = 0; i < cf->len; i++) {
-				j = GRCAN_MSG_DATA_SLOT_INDEX(i);
-				shift = GRCAN_MSG_DATA_SHIFT(i);
-				cf->data[i] = (u8)(slot[j] >> shift);
-			}
+			if (cf->len > 0)
+				memcpy(cf->data, hdr->data,
+				       min_t(u32, cf->len, CAN_MAX_DLEN));
 
 			stats->rx_bytes += cf->len;
 		}
+
 		stats->rx_packets++;
 
 		netif_receive_skb(skb);
@@ -1395,11 +1415,10 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	struct grcan_registers __iomem *regs = priv->regs;
 	struct grcan_dma *dma = &priv->dma;
 	struct can_frame *cf = (struct can_frame *)skb->data;
+	struct grcan_msg_header *hdr;
 	u32 id, txwr, txrd, space, txctrl;
 	int slotindex;
-	u32 *slot;
-	u32 i, rtr, eff, dlc, tmp, err;
-	int j, shift;
+	u32 rtr, eff, dlc, tmp, err;
 	unsigned long flags;
 	u32 oneshotmode = priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;
 
@@ -1422,7 +1441,6 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	space = grcan_txspace(dma->tx.size, txwr, priv->eskbp);
 
 	slotindex = txwr / GRCAN_MSG_SIZE;
-	slot = dma->tx.buf + txwr;
 
 	if (unlikely(space == 1))
 		netif_stop_queue(dev);
@@ -1438,6 +1456,9 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 		return NETDEV_TX_BUSY;
 	}
 
+	hdr = grcan_msg_header_at(&dma->tx, txwr);
+	memset(hdr, 0, sizeof(*hdr));
+
 	/* Convert and write CAN message to DMA buffer */
 	eff = cf->can_id & CAN_EFF_FLAG;
 	rtr = cf->can_id & CAN_RTR_FLAG;
@@ -1447,16 +1468,13 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 		tmp = (id << GRCAN_MSG_EID_BIT) & GRCAN_MSG_EID;
 	else
 		tmp = (id << GRCAN_MSG_BID_BIT) & GRCAN_MSG_BID;
-	slot[0] = (eff ? GRCAN_MSG_IDE : 0) | (rtr ? GRCAN_MSG_RTR : 0) | tmp;
-
-	slot[1] = ((dlc << GRCAN_MSG_DLC_BIT) & GRCAN_MSG_DLC);
-	slot[2] = 0;
-	slot[3] = 0;
-	for (i = 0; i < dlc; i++) {
-		j = GRCAN_MSG_DATA_SLOT_INDEX(i);
-		shift = GRCAN_MSG_DATA_SHIFT(i);
-		slot[j] |= cf->data[i] << shift;
-	}
+
+	hdr->id = (eff ? GRCAN_MSG_IDE : 0) | (rtr ? GRCAN_MSG_RTR : 0) | tmp;
+
+	hdr->ctrl = ((dlc << GRCAN_MSG_DLC_BIT) & GRCAN_MSG_DLC);
+
+	if (dlc > 0)
+		memcpy(hdr->data, cf->data, min_t(u32, cf->len, CAN_MAX_DLEN));
 
 	/* Checking that channel has not been disabled. These cases
 	 * should never happen
-- 
2.51.0



Return-Path: <linux-can+bounces-7579-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKNhL2yL/WnWfgAAu9opvQ
	(envelope-from <linux-can+bounces-7579-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:06:20 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D704F2D0B
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D83C3013D54
	for <lists+linux-can@lfdr.de>; Fri,  8 May 2026 07:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725FE382363;
	Fri,  8 May 2026 07:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="EtmTmwAc"
X-Original-To: linux-can@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021092.outbound.protection.outlook.com [52.101.76.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F97F382289;
	Fri,  8 May 2026 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223730; cv=fail; b=dSsAcN6AVZUMF5NCRCc71P4QngN1eKndCJM1Zi4bjQZC5femZgyQcBQuuoWrlpiKlMp+0ywWTocgTzLlkzRt7eDIGuEBnK+DvSdX4dWEbJ/Te+YQpk3W58Y7XIfi40iUSBXBZNSv+UNFa5AnaRf8ybSkxTKh2s+gTtkBbEkw4vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223730; c=relaxed/simple;
	bh=5zkipCXGag4FuLHwvRv64hDYJvgKefjNobgEY0BNYgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dhj7mwcFh+Fv6oQysAb5eQtIurLsrRfqqmYZejFaYhEUr4jK1abUwkNYdFvnSneWZyiB4RhmknevtcGiBBl3xGnGeJmJdVwQuR1Lt60apXOIt5KVPZyXbN3e6YodzU0tDlmrT0cDM16GaPs/e3o/9hag+Vrffa1PkgLhbGZY4Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=EtmTmwAc; arc=fail smtp.client-ip=52.101.76.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twQ0HAAsih38YS/UYW/s3ZWZLwDkSb4UI0xMks6CCbfXlrG2bLtdReCKV4B6x30f9vlzlVrtQ3psvIilTxiZqlw7MKfle5HvxNkCHHzQr4i6ngP15Ag8RkIJ03Zy/UjxxxCkCRkNB0nNOX1m86SFP/o0pWw+bbbuOtTzSaTPRl3x/CvxRuWbmBbbO+h5d9NcrxY0t9IgRTA4FZywHoG2KAyyG4MPJ4Od4xEZbBETzPK8GRj/R4vzN0IjfCjbH3zbA6y+xK0e8nNmmZOH4m2F5KGq3qxHWXMs/rqrd0ipMiaqenwiubxfUKF64KW0U9MqRheWwflkc7VEhbkXTX4s8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qojfoq0VJ4RAW1ZLCCwvXPc9MEm2rqjzxKLfmBdADos=;
 b=XKuP52B6HJEfXKAG9UummqfP0J4I8L7s8p0IpS5Mq3FUQFM7SJ2LLdY9XYxWfqahfOBSJFnp0XVwGRXVAqp0MRbGdkpmpxmWzVhMA28fofQdbD8sap9hxteizWHkplkXJ01rh99w7U96Q0oamm27JCAUJJahO1tvf+7R1WyVH4BtDal77v55qPookxK70bEBZiHmi/zX8GZjYtCJX1cm6xsLnapM2tihrEnYciO+rrqEExnWmce2r+qZ7GBy/mZIqoExckykbbq7Lu/Ci0e2pjzbHNPdzsU/VRAqQzG2awkWBGgMbTbyYFXvmEk1X0IX/gXzJ2NpwHSezPECMXoxIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qojfoq0VJ4RAW1ZLCCwvXPc9MEm2rqjzxKLfmBdADos=;
 b=EtmTmwAcX53o/I7xzB4MFHeieL0vXTQPMUf7pPSALThcmB1ceF+lRRP7RxJpCVRzzriHNloXYQ9pDqAmGV6jwb4sgTvwGOmWGzjGAUl8+tih35CGqxrkR2VP+sqzWtrosf5DNxrK8oEo01Ywd7iMhgZZmbn+/jkiB4x3/Mr/lLjc5HmUL/3EYcyHbbLWO9yZddH7WKz36O5O6o8+9f5MLJK+ZXaqvzEjDwmKmPX18j/rWPHGByGcrHSXoDO3ce95RPbN1YiLexzQRLlRysVdndUHa+6c6qRTgMS1akODNgVmqXfS4t+p5aBf6JqSITGzLkaMVolP7psQKkkBPf4oIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:188::6)
 by GVYP280MB0889.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:01:34 +0000
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
Subject: [PATCH v7 03/15] MAINTAINERS: Add maintainers for GRCAN CAN network driver
Date: Fri,  8 May 2026 09:01:09 +0200
Message-ID: <20260508070121.6918-4-arun.muthusamy@gaisler.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7f67d5a9-316e-4073-afba-08deaccfa3a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6E0dya4ZaH1/ap1+s8dgkvl8u6TVYJtRvXIy+eWSrj+wqhH72Mj2bCbHD1OuwBH1itXuhxto6zHn+LO4TqF4EnlTe6wuszwlbQbEa0SFj0iS490OdGfRS9Ekhd9PlnZtyWqK/IJzgOiUNJ3vYrArzqkRpnYn25qJ2uxhV2170iAL9sduIB4uS8d7Ui6BXVDNgTeudBp+Bi7q7UumEQbog1OaL5VbgdoCdrYjDgdcg2iHzeFhY+2BfpMxDgSlWqYtGwXZQsUiDiptcIP/ZvoaraIxCTQCZtBxpOyiXuGy+wDFSPVqQQToPEpxqnhYUNGhfLlwvHaY+uzz1xq1ZMQ2d5qvfsXIII27WGPLFzG8MVqwjCPwlvdhpCwkV5JeN5N1nOh2l82y2U2swEyh1K1GLasaM0r34F7B0HFeE9OH+KjE+g9GVPHs4+buYb3o7UsZTxi8a1upXBLvI3x7MfnvR+noRSLPvaVls/yfvd32S0zRGQz+tmkNyPS35nSImoMoOwTOr8NI4M5zI/pPc7DqrfR6E75pUKYSIkEbuK0jhBDRKOqYIEYB4ZOA53YDvc5DdhvGgrcPBxjwC0bfK12Bg7kNHpFrYU1QSLalB4YzgP122xQh1xj7BXZ3SslBbGcvZGkr9JzLhhEhvwE8jp+r2hqe26TkiLrB4lRlRCoPzDwjwTQdgTDXOssCosr6CSbRAKiDgqUTjspXFEEVM7V5QV7NbFIaaFcT1MdV020DhsDHsNxJBrnILfItoQb6PVCX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nuvyuF/LwzkQcjO8EQ/VmIPUXiGPWzZTUPYxxgYaQcTY0G+c8KCVB615oVtR?=
 =?us-ascii?Q?Im0+dbfyUKBESPRvfDo+78qSzpEQhVMG7PMziYoMtMJUPJbagTmwtNw1EReN?=
 =?us-ascii?Q?449DabrR5JMRLXKsDYXJNMDSofZAy82lCiOJwYGbMi3x5nVmMeQXO4skSV4V?=
 =?us-ascii?Q?nBnklIamQeUa/GtARInvvoBjZHtrdW++a/SzA9QMaBdFUZyvQWeHOZuhLoQC?=
 =?us-ascii?Q?/eryvd47Qs+0oOd1+LVVFXTyuyyMCWYDtaYHXYtugiXYDYeA6IWKFZolRjYu?=
 =?us-ascii?Q?lCYSGODJxXQT7XQ9rPx3wpwPB8aivPcQUVytACZyQ9gJSAZPtOYBWSfyPDtC?=
 =?us-ascii?Q?IBNDD8y1f2rbF+l9tVJxeWL5CAtJQSBxgEuUyw3zIR7XZW8EQDdGFpS3RZxy?=
 =?us-ascii?Q?Ect6ZmuehLLfubsO6L+OHWr51hPaTLqVhCqTK/QlduGVwNK0riD/u4LufXa/?=
 =?us-ascii?Q?puZCyvI1oaS25troyW9kvqcC5U6BEUoE9xzRePwxn/EVk8Bvg6JOqPbu7JAU?=
 =?us-ascii?Q?lgS/PyfeiBLrUpV7Gg1CHHySCFLThcVcfr5lsdNqy3ayphRCuVar15E41ABQ?=
 =?us-ascii?Q?5wo92j8hh9wn4zC7cjdUoHCz0vzJC5+CfAC36Klt7m0bsx0rndiVTthz+PDb?=
 =?us-ascii?Q?41Jm6f0yPfI1VwiUJF3ySM3SO9toTMgJ+C6IORDsWtLDlunv0TvhVesfmT9C?=
 =?us-ascii?Q?0tQJ+rxLZ8NoleMaOJnqLS8/8N7fn6zujOdVq+P5/+hO33s7QQMVgdvjpw+W?=
 =?us-ascii?Q?3Zmeq1ZIxZIYdEPeYFUZSKsxXZd8UqUZ80+4Fs7syTRaLAeegC/d1W1mZJih?=
 =?us-ascii?Q?rV0Y1QRxvuXpkvTtW8yHiWf44grtKmW5AU9tgH7Shyw6ddnYoLF/vL67oF7O?=
 =?us-ascii?Q?9XxIjBYBBk725PncPMcZUWJ0HZRtVSIflEVeeYyTweATXFIRULDXiJYhco8G?=
 =?us-ascii?Q?9BoVqdfp5NuDTEkeXTSpDQNtw+hfCz+y3n6nqPmkW2wSWJJBE2VEKguUSLq3?=
 =?us-ascii?Q?HQJFv5MJchKmnYRIyUyo2lfeX0qv7e00HfZSF+bRUuRZNg4o8LhyIYPkf0zz?=
 =?us-ascii?Q?xmc3yU5sIp0UcLD51Thh6GEhAAEpcombfIiRrzGginV2MLTvXCzJgKOuIYME?=
 =?us-ascii?Q?VCSpxdVB5X4nbnxbdsIHysdrxCQ4dQlfy4whgBJ8JZld6fLgjvQJvEYrbc0b?=
 =?us-ascii?Q?xurjptrZZ/Xkqt5/vRUbnXThbCMW856D1+5eJrDdWsl4Bz1Gx8Ek/aPuVNVE?=
 =?us-ascii?Q?BsKlBlzVcrs7s4XAgTFRCRaZNymk+4QidbXkXZWi+Ii9d8vZAz8AFjqka8Jp?=
 =?us-ascii?Q?7suCTXLKo5TJgIteeLih/Vo7woVbr0Zg9C7ASX2LYpaRv1TKpXtjFFywHhey?=
 =?us-ascii?Q?43l4JuugVGlRd/+N57aFyfARqJvc6eBDHRwCBbudIV2vUKRiL75W3p9c5FWt?=
 =?us-ascii?Q?++MG8NvISTLuaiqsR/IrfPsqDj/UtZDvo2aOuOFF7syID8VVreeTVGFvIyET?=
 =?us-ascii?Q?QO4KGaYEdKTVsnYWoeX5+GP3OB68Uci95zHjbN1ecNhJUEbszEs9XCZBE2j3?=
 =?us-ascii?Q?VNoFqdAW0rMAvtQ2JqZ6s8/Os77dzhpOj9iHh7OwCiepai8quH62IBXJLJnb?=
 =?us-ascii?Q?J8Oyx92mVTIU7jv8WsupWxB68ftQ0G+LQdpB6mCz8ZAV4xye96MSL7N1O3JC?=
 =?us-ascii?Q?FnO2xTknn+EpgKxaAzsh0NPZqQDNFlPagL2dDgXOmUMZwvcsYtb0t2LS+Rzg?=
 =?us-ascii?Q?lo0saHrFRK5e3rQ56evnM39VCKbFLYk=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f67d5a9-316e-4073-afba-08deaccfa3a5
X-MS-Exchange-CrossTenant-AuthSource: GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:01:33.8095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBAUOXC5lJIYbf9HWPT6P5pt0kfIr6BIOfKNluq1gZa+9SfECLsdbsZkoRV5okhEq1tqwXVZeZHc88uvJ1PDyfV+4IkwAnhrsivFm0LKxRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB0889
X-Rspamd-Queue-Id: C5D704F2D0B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gaisler.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gaisler.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7579-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gaisler.com:email,gaisler.com:mid,gaisler.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add Arun Muthusamy and Andreas Larsson as maintainers for
the GRCAN CAN network driver, This entry ensures clear
communication channels for maintaining the Documentation
and driver code associated with GRCAN.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2ffd9d37d5..60b5d6212207 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10972,6 +10972,14 @@ F:	drivers/gpio/gpiolib-cdev.c
 F:	include/uapi/linux/gpio.h
 F:	tools/gpio/
 
+GRCAN CAN NETWORK DRIVER
+M:	Andreas Larsson <andreas@gaisler.com>
+M:	Arun Muthusamy <arun.muthusamy@gaisler.com>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
+F:	drivers/net/can/grcan.c
+
 GRETH 10/100/1G Ethernet MAC device driver
 M:	Andreas Larsson <andreas@gaisler.com>
 L:	netdev@vger.kernel.org
-- 
2.51.0



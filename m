Return-Path: <linux-can+bounces-4127-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B0DB11EA0
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83603AC1A96
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2E72ECD0C;
	Fri, 25 Jul 2025 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="k/LDNXRm"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2092.outbound.protection.outlook.com [40.107.21.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3953F22E406;
	Fri, 25 Jul 2025 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446777; cv=fail; b=aSvPOU763K34v2iRNMw3u0e7IhoqmPTA6mNu6gbCm1tR4kQ4OEwz4DMP+KZD3BcCrkmJb9st/Dn5Q3hOYkjGOXdzdk+s/QJEzJw5hVY/r6fvUa7b5WyHgwJ5Rhy49GdGWlzs5imivAbTZUdCMQnt2OUlkrOtS3HgT4oLUWf9Kos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446777; c=relaxed/simple;
	bh=pXZqbvwPPFrl9kzyYjGa6W9MajFauBhmSSKXFxou+0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NOEer5f6QPRVfyzIQk4VdWthtlXXGFDw7gyZWVhgsPNnfrj31mVUumU4iMqavHlBHk6KtuAaaEMC3rLEfAJLXNnMg4iXb7qb+1+5JUCGXjo/Qg7aO59PCw46aFstVKMk65ki3Q8j2/IQ+//TgRv23KadzB9cREGWiPjSLrfGRT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=k/LDNXRm; arc=fail smtp.client-ip=40.107.21.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8J86UEyC4zE4zvl47b4ubh37zks6KDU0yYjVpUz7a88xIRTYqQIS7QiLtZLG/dHeiq3hf00Cu3J5Md6t7vswBSdt2XG9qrk2BDpQSu4E9ocfCfRxt416qJ9rFwTOfwzKu2FoiBm4mijkG40D+DcS3bu9bMMIVzMtT/BpZ9WpPiaRgVYNFlqcL9T5HcvHUOtCBU9oGUuEmz65VOaqjRtm7zRdBzjE/rdb4Xbv8fTBdSMg7jj3EAi23PIQHaMpvIvrwJ5oOx2eYWr9CRdMgWpTdxIgvSvmhN4JwcvexQ9SdpTv7LyTzbn7d5FdbIBPWXeTITW76vzIs9E6uxuJllDYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66bbuMuZ4EH+bK4trDqHT8sB4h18It8V1m5ZuqyYwj4=;
 b=YYktiwxy5luxUvaMl4qx006d+stsml9xADzrcS5yuOtnFpeoyKbDNHd8rO2t/VTkDNL6jh7iQdn9a/lmw++28AEUQ620bRf+8OmQ7FIFdIUP7KRRh4AOCzpaC7I/SnkjGalLVxl/UuYYIFWf23LmTiWP+DDJkegrAK90+mxT3r5cdMF8m92ZlgQtB33WmsWM8c+E301CxEW97tPnq0+movP8ojGISlmwkLIGJFrjnLBcArNt5pXqAmYw8Lci+ZGvseLiwV8P0/kfTGT/qMh2NfNHYdsTsU9kcEDF+Gik4NezFdjKlWF5SKzrrswgKptnHhVM+MoxoWfG3mwVqNJNUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66bbuMuZ4EH+bK4trDqHT8sB4h18It8V1m5ZuqyYwj4=;
 b=k/LDNXRmeY5LO5rJp6xNC5vDyvBGespMHNW6pu8qlSKBwsa5pI3QE71Fpsh9EZwz49f3JbD6nyq+DrOGR5zEn0NT3PjSaaTZ+fHwVaTWs1QZMRcpsfNup7a7uFrd+fVuPQcjUg3nMS9V7HNIYyYFCZxlauhl7w4WmmR9EmwGrQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DBAP193MB0892.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:1b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 12:32:50 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:32:50 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v4 10/10] Documentation: devlink: add devlink documentation for the kvaser_pciefd driver
Date: Fri, 25 Jul 2025 14:32:30 +0200
Message-ID: <20250725123230.8-11-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725123230.8-1-extja@kvaser.com>
References: <20250725123230.8-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0077.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::20) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DBAP193MB0892:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ffee9c-2430-454c-8d40-08ddcb775e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aX4RPpMGdRqp1vR2HABkMqwv/VIIuGg2OVbZAXQkB4mfa6yfutFr5SzSF0pq?=
 =?us-ascii?Q?IujKbsAEDY7Awu7u63hbOTBHJ9daDI82Jm4xRecKYBvvsdQq2paqcDcanQmE?=
 =?us-ascii?Q?y9h5z6CvuaTXkBmLIhBG/L/lFWiieXGdmNq15iX4dc7IjN2Su+JEf5G3AYLi?=
 =?us-ascii?Q?0BntPbht49Mvf66o+pSvEyBC1cQkSQk2gaYw9adyXbwYfGvB2+SDHilQjfvP?=
 =?us-ascii?Q?kuuQdEhvCsU8B1MDm1nFITdMW6SWI0I5/MvFjd3JAwXKNDtO8Bse0Arx8o4V?=
 =?us-ascii?Q?Ql3E+KX+lOpBKnJlSWMe2NZE+6bc0rI55603Y/ObJvG05SB2w2QyyDFgnSEm?=
 =?us-ascii?Q?jt4NjSEZhPll/x1aNThp3DBtp9mf3tvdW6niM2d6l0VJWfzNS8DRKXEcHAQD?=
 =?us-ascii?Q?PxeGkYCjB2QWn3mqPZcFKQ+XtrYx9u/rC4Z8NDER4U++4/jkQTgvcGDZVuXw?=
 =?us-ascii?Q?9ODTD8orxgfDEWsm07/wJCEm3LII8zA6Kj3agjqy6FFEzgbQyleYTJE3ZWeK?=
 =?us-ascii?Q?mAa4H87FpGiug5K0t1oIxmoBCQwouU+dh4T7+luiBTAffOdDXSfj76XzHXRP?=
 =?us-ascii?Q?YLh1SUBFKmy3wXe/Dm1B/SQH1cQuTHbSszuYGEXe4jF/LUNEKc9ybAwd1LBc?=
 =?us-ascii?Q?neAJRAMVyKz/zj0GmHnRPyiRyDzD8qA2CoXA1cplYwHWB28y72gEqEx1Bz4q?=
 =?us-ascii?Q?WpbJsyLbtokqA5uw8W3ef8Wv1AabL9D+Hzd0WR3nD+bKdE54VseyewmjBGNS?=
 =?us-ascii?Q?uiFzoEYfh4dImRV3JRBvHzgfmcBHF6qN3ipbHh/q2EjwYp0Mdyd+TOkCsLHv?=
 =?us-ascii?Q?5USrwvRGwDyPHU4XVkwOASZnH7WyPZSlrOR6dlbHK0oJjdVUipNyTLEUcgHP?=
 =?us-ascii?Q?+KIqiOPqQbrbsgg6Ca75+AUiuj+y6wsOVTRwKJWkmHpKyCtwm4Syh09UNQFE?=
 =?us-ascii?Q?ubf9ToSnANg2Np31dDu40mwvTCZ0oVV9BNaXmoYe7QyMg9w4aOq9kdbiA+wo?=
 =?us-ascii?Q?b/ZfWO0X/ueK2Kit4ww4X/9bRaOC5qz+dcz0c53uNRA5guwaI+ynJiEHpdPd?=
 =?us-ascii?Q?+kjtDDL8rxZ1Iw2c244ZPieu1D22JloobbexDvIOevgt30+J/yYy/KRhZrk+?=
 =?us-ascii?Q?AbGTYLcmS2KjFFY6mI5uhXfjwe8dbqngtvnD2WkmBC2ArJDf+59kqk6dOeCC?=
 =?us-ascii?Q?VvkQzGy2atfFvWTyzXDDk732Q6ou2xueRpqEXVlS1z3m8RhdpbTvWIoGNP5Q?=
 =?us-ascii?Q?72aBa/oBXGfY2ooKofALIt3DB5PhQ8/dbPjFA741/0XMoAqzTLegdEmhp7PU?=
 =?us-ascii?Q?YL6Wbd51A4SdGfQLPrvV8aaolEA+UWlulbGdyK9Rx5/IdvRxjr1mEi/dUQ3u?=
 =?us-ascii?Q?h341vAjDNteIH4YQn0r10Kt8PxQp5doOgbDFrLgK01iDcvwWGM/C32PZ/+HN?=
 =?us-ascii?Q?WOjBAGOiFwY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sLHFM/d7DVOQyEAm3/vRayZcKKAJT8skfpJ/lmdYn0mg2a08BE2J5uhX0CUh?=
 =?us-ascii?Q?nfUy2oi8b1k+t0hFa6g+a3bSsZ4e6tSrOemQnKjDNd6u1Rpm8yIBf07Nhmd9?=
 =?us-ascii?Q?+/IayUxD0mvnx7gNIGs4YNh3oqsqIgfLwCWJl3M72Tw7E5NGZPrHzPD2Irm5?=
 =?us-ascii?Q?L42uIeUs8KJKapXeONy4esruhRJctSCw7g3beRBryAbhhnjakWadbYWoFRj0?=
 =?us-ascii?Q?GTa/BBK/PQGoQ3ijJHSOHONrFm1TJ1kjqZ8bt/NEt5pQxsKB2rdUrmtmilRk?=
 =?us-ascii?Q?UJQtLVFuvNIQHgzP3ZVsmGMy8iiRMmsI+yYY8dVp528OeDMdjBfa0dGcPz/C?=
 =?us-ascii?Q?69P75u74gaWJMzYG9Frg2QjntKAR/FsFprEjt+X5I02+zjFPoiNxKXDGDgp6?=
 =?us-ascii?Q?CEJ0TM+p5cHb0NrHoXq71GJ1Hlbxo8aOFtkBfUo4b/8gmsGyANeqGDU44UFs?=
 =?us-ascii?Q?WttulFa2hfQeBpXlwu9SskJyJN7N8DD9Yv90uVl+s1UqsdUAo7BEdxaB1XiE?=
 =?us-ascii?Q?SOkJqTrtrf2RzJU5FJQ2gqV1508GZnn65tFeR2UDgwVUd6ndXLcWCYAvS9ol?=
 =?us-ascii?Q?jcoDnExOj3Xp0OdQSW59JLT79KFRZV//UIbQ0+t93a1gs889K5oiRn+FZ9EO?=
 =?us-ascii?Q?kaK0AxLjV7DINsAJ4AXpO4QfbRX/k0DukdYsF+tHuJKaoMAdLnFf7mTaq5Ws?=
 =?us-ascii?Q?0jyd+1L0q7xlivk7AmCNoFaUd8uRmjATU+38J68Y2U1ECem8sEIhUu3J0aGp?=
 =?us-ascii?Q?jG09tgGCE5m+pujo7oDOOb6Z3hXpSR5EMrrjqTPQoV6O2W3JAgjwQ9gBjT6Z?=
 =?us-ascii?Q?+SLxypEnBj5h1qn3HyzRq7dseWfl/9V9sk8Vi7ew+K7ivWDDM1YNGQ+jNSvF?=
 =?us-ascii?Q?ePG81qvm9BrZeO26CVNj9Au7E7J+IV/HysxwkaPIe2/NN3oTU7c8Amgm9dFy?=
 =?us-ascii?Q?f12YSafPid91nrZaB6aLDZA6p9aMloOYmjWybZxbotkqaU7IKCrTM2iKDcbc?=
 =?us-ascii?Q?/5vbKJwPwnXIf6pHWYp1y0Lar2zR9aTjiCvDVLPagFKD8UMVt64dPGdETIMr?=
 =?us-ascii?Q?uVV191vv5Ysy86kpgLlVb06KkXcz12XzuwZYwIe3JI20HCYP0C+O73VBKkSZ?=
 =?us-ascii?Q?9CPT5mKk5MqCzdKYzugL6El5+asAN6JhJFPp83Fp4mrLFUq6miDtNc4jcO7i?=
 =?us-ascii?Q?9dpSAC37zCe8Tw3eM580bsuW7bsoX5zPho1HfVKY4xE8DDpNmwvQHCnqe/i9?=
 =?us-ascii?Q?ZdKtfKzxCT+1HXLe4GMDK2DN9iIcGMCbUCVzfMI3y2ozQKUtW3FUXQryZL9Q?=
 =?us-ascii?Q?kPrIJ5ApKOHnF52CdTUn6oLiV62u3O5XF7CWjkcQCr+hzv9kSJFGg+ey9tdR?=
 =?us-ascii?Q?Fxydlq0+mh3EM5W7hmH8YDOb+2P3g9bgOeeeu2o6e6QsvwvAC8Opzuk9tpal?=
 =?us-ascii?Q?rICzaec8PsUgmv6nKmnzNrI6sOjN76CkO0IPoHBUVks8JiV1wfCWAG5foXIS?=
 =?us-ascii?Q?lEQlub/Exk0KPVt5X8NnLmbp0rzIXzx/j9+NZ7zpU/GO4o3yG7REbpghZgAy?=
 =?us-ascii?Q?lBUZd8sjzhr6W1eqeGAoNk3ercbmfbSayqHuCRDMuHysecw0kgmoo2Zwdr81?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ffee9c-2430-454c-8d40-08ddcb775e93
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:32:50.6694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gey9rkjYO97zSr74/uUASOwPDf3xsF9Sj1SCXNOvSjyAQCEJtZ/8No06Du+lVquWw6e3ONODTm0ENlUV3gcgyuqSOwjrPS7ChAgmj8mvImQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP193MB0892

List the version information reported by the kvaser_pciefd driver
through devlink.

Suggested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v4:
  - Add tags {Reviewed,Suggested}-by Vincent Mailhol

Changes in v2:
  - New in v2. Suggested by Vincent Mailhol [1]

[1] https://lore.kernel.org/linux-can/5cdca1d7-c875-40ee-b44d-51a161f42761@wanadoo.fr/T/#mb9ede2edcf5f7adcb76bc6331f5f27bafb79294f

 Documentation/networking/devlink/index.rst    |  1 +
 .../networking/devlink/kvaser_pciefd.rst      | 24 +++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 Documentation/networking/devlink/kvaser_pciefd.rst

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 8319f43b5933..ef3dd3c2a724 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -85,6 +85,7 @@ parameters, info versions, and other features it supports.
    ionic
    ice
    ixgbe
+   kvaser_pciefd
    mlx4
    mlx5
    mlxsw
diff --git a/Documentation/networking/devlink/kvaser_pciefd.rst b/Documentation/networking/devlink/kvaser_pciefd.rst
new file mode 100644
index 000000000000..075edd2a508a
--- /dev/null
+++ b/Documentation/networking/devlink/kvaser_pciefd.rst
@@ -0,0 +1,24 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================
+kvaser_pciefd devlink support
+=============================
+
+This document describes the devlink features implemented by the
+``kvaser_pciefd`` device driver.
+
+Info versions
+=============
+
+The ``kvaser_pciefd`` driver reports the following versions
+
+.. list-table:: devlink info versions implemented
+   :widths: 5 5 90
+
+   * - Name
+     - Type
+     - Description
+   * - ``fw``
+     - running
+     - Version of the firmware running on the device. Also available
+       through ``ethtool -i`` as ``firmware-version``.
-- 
2.49.0



Return-Path: <linux-can+bounces-861-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C565D91728A
	for <lists+linux-can@lfdr.de>; Tue, 25 Jun 2024 22:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58C41C20F47
	for <lists+linux-can@lfdr.de>; Tue, 25 Jun 2024 20:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8178517BB2C;
	Tue, 25 Jun 2024 20:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CqvZnWr/"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D986632;
	Tue, 25 Jun 2024 20:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719347525; cv=fail; b=Sc4v8kYnvfdFBZTao4Cv2/tVP6/SMIUS4KRcEYja+yb66ztZptdkir1CDc53w+pmyLXO66ciD9K+l5F5X6x7Igg9NvOShVa7mrGNZfp9pspfYJXUjN4/XvNBeEa/iNqBzZbNBXlul4CwKzSlJ+XQzp2+gmPBqoi5NQvFvQvuToc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719347525; c=relaxed/simple;
	bh=KIEqt6N/6HHFUSd7K+nW98TQaNO9tpTwWxmoi3HO/xA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=h1fsdzmrHH8EKLT2yQ3xFpCFFvLmYS4KTIB6YNB73g9nZBeDbtx55HHXjenJFIgYrihD/BzC2knnculte8DbtL7XLxwD/aj/wYfS1nhRd6UK8xxpg36TzTOJ7gOfT7JQme5g8k+CANQqwWjeLvt0za+SjNHoSwIB8lPkL23ZZ8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CqvZnWr/; arc=fail smtp.client-ip=40.107.20.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkpNyucmeR6alM/SwPX5PlSHy8Ma9CCBblreN4nOUK2gmXZxx4dR+9eu7o+8u8t2hWXPGaG2QB+4NW04erVm+mZvE+uKQlzds6R0eZAeYAvHakLpIkfHYesToDHYFMjIx397LdwTFzGrE9UgCeYeHTCDsX29NO/2yq+2iutWdCrgjjIxCfU0m3bX5W6fkxYErMMNsoSPF2CY3ga4B8ayYZ5p/9KFMb8UhENMPOcK/CRMrck+Hud1aQUuOB0QZ/mMEQuMgDflJNm/yHarGljnxkstDNpaKyWR1saBEnuf6cY8fVsEsnGs1T+DiTME+ykruvPhvzzCyF5zMPMX9WZXwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6uaDqxJjfZ579vh1VUuf8qCmTyAxhb0nIwJj14a3/4=;
 b=IMxs4YHabsqw9XzsdXirmNW4QWF19IwsmcWGuF5JvHaMfwX1sM4Tm3Or8Hy4KV94aMTlndrMO/IrNuUu/v1Rw04LImBm9MRrtyHut5eXxH6rWYYVbr7bdrjl664VG66C3QQfIRmeGcRVbBfX4fQ+EaMAr64LpPKlOpkxyR35VfxfVfA4KIMm9d8IpQGXT6oQcWC8t18evBIMyI2tJ7Z+oJma5SZIGbZuqtI2jRajNOZUINwiLzxIcBdUwsL8QKhuWsuPoMPcP5H3x5bVBUXypa1CCNcA/ZxZ4955bCMiFcfio1NG/GU5+vKXf7AeMjAzT/CCfxDC0zfkm1yYLWBThw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6uaDqxJjfZ579vh1VUuf8qCmTyAxhb0nIwJj14a3/4=;
 b=CqvZnWr/Y436LLo9J6cQI4v0OFdQakuyA7dHyx4h4kh8i3QgDzKzFEtxfA9OLTUBW+itteox1smJHF4npMC/413ooyLYw1PX28HaYQ84BFhkllr/+6oecHqkDVTl3uyiKx+i6rfcdM5osNYubElNLDyZbtsZ9kSNk6xh/YkamCs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10219.eurprd04.prod.outlook.com (2603:10a6:800:22c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 20:31:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 20:31:59 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-can@vger.kernel.org (open list:CAN NETWORK DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: can: fsl,flexcan: add can-transceiver for fsl,flexcan
Date: Tue, 25 Jun 2024 16:31:45 -0400
Message-Id: <20240625203145.3962165-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::42) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10219:EE_
X-MS-Office365-Filtering-Correlation-Id: 03184f60-90db-4db4-e00a-08dc9555dd01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|7416012|1800799022|38350700012|921018;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Day1TBs7ilm1fR1yovkJHis8ERQD0Htq9Q6dvCZPFZKsqbSHoe+Wle6lWDjr?=
 =?us-ascii?Q?JrfBI7pMAltpfX6FBrzvNuKEIn2J0QPAyMuWcwcXIS5emuJBnVJgg6YVt3rH?=
 =?us-ascii?Q?DZmyQqSX1kQTAmVHXNp6GCGOKk4YJQwEIiJvVVAxOuZAlgHJmUMM5ctLwIpI?=
 =?us-ascii?Q?PIUp6XS4fMWxEjircYKALBooj1ofXvYxe3OBKYiqqv5QPj5ls3oMCjfWmj2s?=
 =?us-ascii?Q?rkNew6xPlXqOfEWhKZjOMBDxnoh4abFs4VDVpCUK3k6Q9sPK5GG2zemXo91F?=
 =?us-ascii?Q?UHZZJcn2mkGAKvOebbGshb/K87xITu1yEzhANgH9/JLkPE2f1SocyVjygNOy?=
 =?us-ascii?Q?VHbCCcqCkZQyPjZyYS/g6h4mY9vcPHECtxqypLOBHl3mJ1ZxI/W082c488b+?=
 =?us-ascii?Q?UKXYO4J1rzSIPwuOMhu9To97qDgBRjHVDq1mdp9qB2IQFo3pwKRSLI+xRHLc?=
 =?us-ascii?Q?nLGsC8NWIi8aKC9KI0wh6jIp2VFeSsQEZ9CqMSZ4gerGK6n/syPLjj5LhpxV?=
 =?us-ascii?Q?ld75Nfxd7CJvie6lKHKhoOF6LUR3b54iEgoyvWIuQnuY0UBjoJ35t+cbmRek?=
 =?us-ascii?Q?QnTJvQ5meoWjAflu3pXyld2SobTtjtmEJ7a9TvNDndLTflcLHZ9c9O3IYhIM?=
 =?us-ascii?Q?7jxumQtXzipy6GfiYnzg9RmbyhI63oEuem9Z9i4HxMYR4m2dAzlPTvC1aZk0?=
 =?us-ascii?Q?ah1RrkgalY+DBMzFsHakO02t7cg0L3sRRfCK8WFJpTUzbJCiqQy7f4RpV50t?=
 =?us-ascii?Q?jcbW/uuOU2lLRa2mWg+HXpdeP1hKnLMoWTKIi57EStwaFw7AfB01YL7/e8wH?=
 =?us-ascii?Q?e9woGOnohIGoEXEMj3JcOylylWpG/E/ms+dOl37pxWsk1/YHgyhZ20+qnUh2?=
 =?us-ascii?Q?TyY7dg/bCV6ebnrNaNzA8GajGCTUNc/Io01pEtbuRiIjHFn1+N0NjkdhFdl7?=
 =?us-ascii?Q?XSqNI9XvlGsORpcv20tKBiie6VRfm69mizNQ9cucZ0ydBwmkGglcSh76Dkve?=
 =?us-ascii?Q?2jE7TtWUKKByPtE34nfo4c+29Hacd8FR1AZu6+QxdFumRLOKtNTGz6OWW1tx?=
 =?us-ascii?Q?VUdMq3FTHE58Y69vS2gF/M+nK0AYa/nFziTHDAkvmUAcSyMw0I5ERMOaJaon?=
 =?us-ascii?Q?Pjayd2MNxVREU4KMEdSSga/XQThJVdKrmpSoJ/7dW+qpxjC/O9MHdxxxkuEN?=
 =?us-ascii?Q?3MqrbPlxZERxJ5gPVeFTEYTpCu2hkahUJ6r9DroKodZvNmlvqsIngN2mdDWT?=
 =?us-ascii?Q?fFghhU+JMpnHjyexgwa7U56l1P7Mycs3OWLBikTTMj4xacIxMRxVhzVBS68t?=
 =?us-ascii?Q?6BnXvzjAPpW/tCrRktCocXpJMvUmrJsQW1bQnGDP/xDE5745KsT8Faz8PvJi?=
 =?us-ascii?Q?NIu7NM2OCVPqiH1Zk0WW6vy8RKm/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(7416012)(1800799022)(38350700012)(921018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SDN68ZxqCUk/NAaNVJ7Nltd1A2Ycl8OEGv7gEy5mOolj7xZOGswda/ycg3G4?=
 =?us-ascii?Q?2atdcDgVKbUJi4o9iKUWDLmCtHdWjmymAOTFjRWlSOqzXS3S7jvGd/W+7gW0?=
 =?us-ascii?Q?cmy7ZBVoJ2RKnUOkFMlTWZAeVpoSUG6VLe5/vw4ziodBMdcfoWkyg+pbdgzR?=
 =?us-ascii?Q?4YqPHvHL9cxcXk/l9xpaXYannusDjjgryOKK7+nw8WR2SGrk8Oyt5LJ8xmjJ?=
 =?us-ascii?Q?EdPIt6gdVd4ubipTB1+ojG3ztSx/ocjXzmOTSy2zwFaCZNSEfXvDkLMU0HHi?=
 =?us-ascii?Q?psv2rEhdG3MZT3aDDFhAaNvvAIhe3vFbiaecM4epw7wvFjXKnme7A0XVYVJf?=
 =?us-ascii?Q?B1TIRzZyJPg7vA/CJkfkjSKGNMVibyG7Y6s02bLDJhW4c9BcLGBUTKEdvI0k?=
 =?us-ascii?Q?acAdol6JWvFNTzknn31dAOPPOFIzzUTZJk2EWc9SEGzqp16Oc34qyYp9B/oj?=
 =?us-ascii?Q?UhGXL7FKVlAiQcPt/MjE9BzHOxuNMuBsxu350WIcicy53W7Wb0fqMXfW9frr?=
 =?us-ascii?Q?OkePIX3Lr6YgPvcCUoBltYXducB32qC69yp56xY1YnIkyl2buKqNX6sJKjJa?=
 =?us-ascii?Q?ieOGCSJ+n7vyUuQ7cysV5z5nH2U+4xZGvFi/LpEEuoOJfn6owZ44zVjVbdQi?=
 =?us-ascii?Q?xzBBCBPsQ9E2VNyTFIPrjL692rEUj/WJT1Rwd3m3vnrT+LleenjctKMuvJZo?=
 =?us-ascii?Q?aNccJxYN8M1h0e9a0ffZw0ZDpQXVjGIxHA4xvCrqDql6Wre2yoF6tKUbTnmD?=
 =?us-ascii?Q?lhba9ivSaLVXU81aQAdpdAySamx8EzSBX/pdkI6VtNx4ZZcswdl/10sRHPJ+?=
 =?us-ascii?Q?qd9k9oo+ulKIucTR6an++Dqqr9qm+sHZnARZ0m8bGwNAs0PgoOA5ZQRcP1tR?=
 =?us-ascii?Q?5nPJ5AoQMWuRLksxxR+JrvEHR+n/6x3E1Dmnb/fUx1iFrW7GlHjG/Fle4aaF?=
 =?us-ascii?Q?MqtSHRBrxVYh9EgUrNMzy/KGNbsErgnsIWR3BPS1pnYhaXh9pcGvYQeMTEWM?=
 =?us-ascii?Q?R7Zlx3mJddpjKxbn+z62RUa/iUOm9S3EcEtnu+gEthIssQkpDPu1LRQ9Eama?=
 =?us-ascii?Q?oMt6zD12Kp3JmNKLRyPsY3ZU9o7f7Kst9w6R+TXEkWF+40n1dV6IRwto128U?=
 =?us-ascii?Q?VMftvQS3Kovvg9WmNmOmZyP7DduPYtGId6JEryjEYQn4Z/6i3mpIejmxEq//?=
 =?us-ascii?Q?6TUR7I7C6AWAk8hoiycOniV313Ai+hVzYhn4ay6PgtBfx0d9oXGAJbrjuAga?=
 =?us-ascii?Q?lqmEUUnvLvQhi1DJ2O9UxPVssrjxWJD5Bp1AXqeDrIa7k1uvzcjYJNBgIq+x?=
 =?us-ascii?Q?ZWhj8b/z+TUxuNN0VIgEuLbn3wIqCnyNtvU1D3DmmktqCoI0P8PAt70NUMMy?=
 =?us-ascii?Q?oqExyE4U+XG5twDoElxGhS6Ae/jn5ChBBDtbiPcR1yliKwKU0VBAxtFxisyH?=
 =?us-ascii?Q?QCywuAMgU1wgWFtnetZjjoTr+f80fqTtfvbfZMtZxQVkG23yTAnylurcTwEi?=
 =?us-ascii?Q?1vIMcGYzRZyvhJ6GElI2HwCrN9xKrd3VlOJegFqf+GCk5OLVxTQMG6HpwFQk?=
 =?us-ascii?Q?BHen63krz2DTVr3IkIc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03184f60-90db-4db4-e00a-08dc9555dd01
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 20:31:59.4448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrcK/07yDpUslHDWlJbXSqdLMBxAPijJOXwwWrNMuF2JHv6C3E3Jb3LmlXHoGkwkI2In1CCBqIxZDuPiy6zJPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10219

Add 'can-transceiver' children node for fsl,flexcan to allow update
can-transceiver property.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index f197d9b516bb2..d003200247b03 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -80,6 +80,9 @@ properties:
       node then controller is assumed to be little endian. If this property is
       present then controller is assumed to be big endian.
 
+  can-transceiver:
+    $ref: can-transceiver.yaml#
+
   fsl,stop-mode:
     description: |
       Register bits of stop mode control.
-- 
2.34.1



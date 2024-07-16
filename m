Return-Path: <linux-can+bounces-981-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319A493298B
	for <lists+linux-can@lfdr.de>; Tue, 16 Jul 2024 16:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9F61C22059
	for <lists+linux-can@lfdr.de>; Tue, 16 Jul 2024 14:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9679B1A08C4;
	Tue, 16 Jul 2024 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dvOMRiMA"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011017.outbound.protection.outlook.com [52.101.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3AE13D630;
	Tue, 16 Jul 2024 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140847; cv=fail; b=XEW8M6SwHG8ac4AXmba6mS2UjdYemgg147c9Rz7UCkWXTcgJC6a/dZKLFI91most21tTwtq1W32x1i/VnUB4R/1d35Pf6cqVO3jA5xG7g0fpkoiyHlJGOmoX1ieZ680e5ZLqDIzQVuBDGU43k4XNGwiGDVDm2uUT3FaI/dK5iy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140847; c=relaxed/simple;
	bh=429cTxbNmaiHmmkSSlOIpDpI2yQpANQyl+mbARSVBZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kAdo4ri18V5SAvMYK0fXptTU9r2PRH5HQ+RAN+0Y0reCuu0nlms3KuS0KaHq8MmJWBDXG6se0nZCa7QCPRufk8DlwI03qoO9+mlTwJzWkunxoCq6bmbttGPJiTniHrO8AR+894ZWh7lyqdTVuQsL8OlB48xqBnppLbeUrhav2W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dvOMRiMA reason="signature verification failed"; arc=fail smtp.client-ip=52.101.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZdIpZhfPDTDOMnPPzyLPMt5pL2KcbVVKV5q1rAEo6GLyZN6pIZ6PnFnWN/SuEBvdFAb5Dh/g98q6n9CCM83oxEh459zAxXdYH4cdTQ/+mr886hd6didJahJfQtc7smJL6gqXO3sXzO2/JAcBKjMvoJz+1r6r6GBfD7pcJ5LnH8AsL4T0vDZV81lHpkXmYj1j39frQaG4drWF6uwIYw0vJFKie+FVWyN/c396P9c+26swRSid7bU6zolQXXCWOWKFmV/RlFiN45gh3KBbzBizBTlg8tTJy072+LIlpSjd8f+N3S6Nhghkole3WmO+e7KST2e/cel2vYD3RBrYQ+VLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mHJ51gxXa7wQTx9orMeBTcCBJI3/WwcQvtyIXSUIdg=;
 b=NNKwjfvV3wZljIFIhMVVZS9rNiIcZbeKpSth0GfwyN6KQsufV5qRXJEiDWNdT4SDqYQ9h6QUlSR0sUsEbZzmwIoP69ACgQsuJ4PlX1vv875HJni6i+A/saiIt/jiE5GGoTllH6/DPgZZ6S2Oc/9UPFOwDL+S4wqUc+4psp/1QuPMia3CEDMmWknFj5SRXM5xnkO+rNDEIhIJOR4lNILG0jRiqjL1UgbiTvn2JTahWuEWKvNfjiZy5DDDoK62tPOWsG0FqFoQtz3zDJFZfJLgXrR0JIWvz8CcuCxWySUYv4CXoQ/xJfUGWKgi9nJsy5QUuZkDPUQjXxaPK5R+4VWWeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mHJ51gxXa7wQTx9orMeBTcCBJI3/WwcQvtyIXSUIdg=;
 b=dvOMRiMAYIT2fVgkqkSiepEljqu70WfPUD1Bll/QYe82ip5J0yRjspH6Cf+vNucfX1Pf39PbtiAUruVAaYCgNDfIiHVm7++ykR38EIVn00C6kUWBy2GMSKRKHFwOP0A5IpTCXdyibfS4aHpONewYkNt7pbDoBHOkQCOg/sm0tZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7054.eurprd04.prod.outlook.com (2603:10a6:800:12d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 14:40:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 14:40:41 +0000
Date: Tue, 16 Jul 2024 10:40:31 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, haibo.chen@nxp.com,
	imx@lists.linux.dev, han.xu@nxp.com
Subject: Re: [PATCH v2 4/4] can: flexcan: add wakeup support for imx95
Message-ID: <ZpaF4Wc70VuV4Cti@lizhi-Precision-Tower-5810>
References: <20240715-flexcan-v2-0-2873014c595a@nxp.com>
 <20240715-flexcan-v2-4-2873014c595a@nxp.com>
 <20240716-curious-scorpion-of-glory-8265aa-mkl@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716-curious-scorpion-of-glory-8265aa-mkl@pengutronix.de>
X-ClientProxiedBy: BYAPR07CA0060.namprd07.prod.outlook.com
 (2603:10b6:a03:60::37) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7054:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d05202c-5385-41e6-66f6-08dca5a543f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?NjZRRHO3lMk/qK/aevu9MXl7F9Yx2eXr5H8cjfA6gGlFnyUS35jRk9EW0v?=
 =?iso-8859-1?Q?fDNbbbsUhjxMLJ37FGomHPACjM9n9bj1G+U1qsBn5DYUwUWo5JeVZGR9at?=
 =?iso-8859-1?Q?JQd/4Ip1WOM2dkakoJIkkNxClRSZSW5i+mmCeSB8pIuRm33d9k2T2SNHy1?=
 =?iso-8859-1?Q?PncM+eWE+51jz4/kIctyIWGoK6WqLqhEthtTzzTIRFANwB+70L99XhEN5L?=
 =?iso-8859-1?Q?Se2B+6WS/txqlOuIdrk88CBRIdslUF9RbOQ5aQOMkw19/sqrSsD5zjjbFA?=
 =?iso-8859-1?Q?jecmj4T+iT1EuMd5TCTplfUKcudCia5CsENJqlsQfP18L1UpN+0VOGFjrv?=
 =?iso-8859-1?Q?5oILy2XSTevNU1SvV5JO5HgUZ/Qu4PiZAsfaiG3rvweUxvI6K19p1fyh7H?=
 =?iso-8859-1?Q?4MXD0eUQdtCbg0mAxxRQAGeMYpIlt2YVEWP1djGMe07gEx5hTSC2WpTUYv?=
 =?iso-8859-1?Q?ZQf94+Duoe57Yhqj5NDdJu1UQrPzUGvvPbu7W5MhGG3/3ITGr7WgHBLyzM?=
 =?iso-8859-1?Q?wvqiz8FMR8uZQhMQyKBLdqiBr4g8GiwWQFh7eC3zND8aRVDctjKBYUaoAg?=
 =?iso-8859-1?Q?QfTNJ/OSDjtBH0osQ4vflfPRCzILo9y3qDIfAcZgacIem/QiAIZGaRMy92?=
 =?iso-8859-1?Q?CEVWCJnylE195ZmYWnDNRGP2s2ZUd1VU0NycyqaNFrJfYf9x1ygtktLEtE?=
 =?iso-8859-1?Q?DBaBsokeoX1rlSX8wyPdY8/uswVI6dQv9cXmMPQRuYlpTEg41eVpghnqwW?=
 =?iso-8859-1?Q?9h9ljXlK9ZjTIcy0PbIenN/UZaTcRSkyExW49Jgb0e5TSCjqbDnQgNdDkn?=
 =?iso-8859-1?Q?ND1abj7lEfLo7Dm3cBG5fo3R0U06EbiS6cMZxo/nrk7VKYu/lDjdsQGa4A?=
 =?iso-8859-1?Q?ArVc1zBYumAYpvIzsrILrI2EzuVChEpu1dAb2OR3u42IhQZDJrXcCj9hXE?=
 =?iso-8859-1?Q?MuPcSpf0N8QogFaEzLwx+7LwwL2xq9aZTFb3K+cyKzu+dAbMB6bZt2G6Dk?=
 =?iso-8859-1?Q?vm8kv8WH6dg9EEZeDZho2DbaCho0h+scJsh1rSBQpJ7DO18sRfueJ8myLH?=
 =?iso-8859-1?Q?n2d9efpj6KnC4Pzk+Qqn3kRuiBB7XhXr23Y+B7FklTOyeUc8ftTgE7KUiq?=
 =?iso-8859-1?Q?N4SyppgMLYkDjhN2dW2Irsg5k6X3dHRN8EpnFAJDQSDh8V3tQ8TD3CUVLv?=
 =?iso-8859-1?Q?4y7EA6Er+6RyXrbAeksN3vlEzwH3DO15YMh/U+uiWfaRcKeYYDPXnDGZGL?=
 =?iso-8859-1?Q?lhDcoIgITSXWapWhIWoDQe9UQE8Img6fHMLY+2rRmbrpr7/kbTRXkBULp0?=
 =?iso-8859-1?Q?aehUEHKvaKw3LUzZWnvIPPsIuvfLwvzUPKClPpwGjQagRRjsAqUjnksY98?=
 =?iso-8859-1?Q?uDZmJu62Xqqrk0nYEryD+QvqNCa2XuJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?/k6MnH0onkqdtFcJo9YonjAOgFVfXledA2aJjl3oUsT8So2l/J3/fN839x?=
 =?iso-8859-1?Q?Sqz0cbYoeUyAbPENVa06j/9fl1LvsTOwwYmlR7HuSCHCqIz4F7LWuYMqqw?=
 =?iso-8859-1?Q?Bwte1ktZFAfOVq3g8vlgIp995d7qxfb1qfLniJ5JZAUj9mBP3bANxuUAsD?=
 =?iso-8859-1?Q?XwXsJbZJ0C8WA40z3AgY52UduLClGgGAR6iV6lUa0aMoef0Dx1T4M7CXcS?=
 =?iso-8859-1?Q?Wv+U3q9C7sXoI6ikg5R/gUVbqzaHBZIwpb6yGbva88HS1ANhszXCnWwDQ2?=
 =?iso-8859-1?Q?RyJ09UMqSrCIX48ZPmBGR0kc3NgQWrhWRm5+I0x7fw95Y+iz3K5J3ZhCf4?=
 =?iso-8859-1?Q?NXJfDSKLqsJmMeT0IeayDS2zoXc2t6UvaKeTMCtYn96Jnjqch0QqglbTux?=
 =?iso-8859-1?Q?E5wubRa64liAFDF6/cg+Fac6AAiOrVzygi1ui6tXVpZfS6xE31xP8tp3Ig?=
 =?iso-8859-1?Q?+tV6wex1fqhUYkTRioTBj0ifNoixHivVhh4M1lblbFzORTgE9v15OyezB8?=
 =?iso-8859-1?Q?qmArH62NrpP75W4lyiv+NeKgmDNas6oaqrXkzOoS6BE8S2uxgCmgo3k8PG?=
 =?iso-8859-1?Q?62boBAgMw2jaTopoGbqVoONm5snrvDe+tULyJbnrsHtLSmIl2Bwd0QN6Uo?=
 =?iso-8859-1?Q?QxdFaM7KpwFZdWr0rJqZw3QAcNQWmW9ia0bdZnfSFfQg6Cpl6GHDBCWc4x?=
 =?iso-8859-1?Q?HSKdxcRs2nYk/5g0g+4FaMRRAWaYfNUyT3JFZ/pwzHm6k8TKqpaTj0CWcw?=
 =?iso-8859-1?Q?CsF53RYp2dIqZ1LHZFBSWHFBGfs/amMeu7GOhfe59JVxh6J49knvSvQOPn?=
 =?iso-8859-1?Q?oqyHDxWTy11TdmzJ/vUT+mCp594Lwt4N2QhbMFKTaoUxKG/emadtHKnGiM?=
 =?iso-8859-1?Q?myBI35f/PwFGji77t+RfEUQXc02N6fyozSqlkNS7NVBvAM2oTxZXevsjJQ?=
 =?iso-8859-1?Q?YftVANJI8rDSZ5gmgv5+1WcQA8VgmAjkjJ0VDZMBN3IspK1MCGqWahnLTX?=
 =?iso-8859-1?Q?i2TudeK3w958aPLtTU68pSMhmUsOetpWU7ddJAbaJQGvaDoZ6e2QiMUFhB?=
 =?iso-8859-1?Q?diwQAkwBTGcMB8wY+9dQEfcmiNxnnRjW3v6U6LW7IGZccqtgj0h49mORa2?=
 =?iso-8859-1?Q?wkJ4gUEBNHeFisEafjB2BInfkEMgk/kD0vhBT+Ntpy3/v+8BNGxrgU45Lw?=
 =?iso-8859-1?Q?WJqCU1078T6uQaix5GvfTAD5+v5lxBRE8OlNscw9uX4aKgaYhqi/MTpWls?=
 =?iso-8859-1?Q?jdtlLb0oQZgPaOIh/fyjScgXb+/DIANLbTIcjFnN+zphm1MJVPyXaF0gn5?=
 =?iso-8859-1?Q?Leyu2QP0ioMAUaasSfNE9uDKZqiwJIBOeGpq6JG/dQ2luuvOrm90BkqzhX?=
 =?iso-8859-1?Q?cCbBNdJasIxNoCCT40INUhpLlP/sDC2HqCjrTDucJ7AbiLJzah/AQzENuv?=
 =?iso-8859-1?Q?t35zLSbmMxAMxZrsKrJQgOgLnIUniEW6I/X5LD00r3SxTxgAVY4vgrvLRC?=
 =?iso-8859-1?Q?lOizNK+Q7u+zejt+YcodaXkmIjhLqhnatrHSLKdqEtbmbvAMH/OR25Yu2s?=
 =?iso-8859-1?Q?ZWbknX35LAbehj2jcWvNUcUWKvKYAarUYNiJHmtytvSe4oSWYybaGU2L49?=
 =?iso-8859-1?Q?Qxl41s1uIidVLlh8kKNMmvdF+uy3gUGQwZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d05202c-5385-41e6-66f6-08dca5a543f0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 14:40:41.0403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYw1WgzeGfSFEXnTWMPKYNOpzDi3Y7VWKyp5Eqot/9JH9/NOAqPBSEyqTx3/I4BqXQxaP/XM/6XgnCID4nUWzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7054

On Tue, Jul 16, 2024 at 09:06:14AM +0200, Marc Kleine-Budde wrote:
> On 15.07.2024 17:27:23, Frank Li wrote:
> > From: Haibo Chen <haibo.chen@nxp.com>
> > 
> > iMX95 defines a bit in GPR that sets/unsets the IPG_STOP signal to the
> > FlexCAN module, controlling its entry into STOP mode. Wakeup should work
> > even if FlexCAN is in STOP mode.
> > 
> > Due to iMX95 architecture design, the A-Core cannot access GPR; only the
> > system manager (SM) can configure GPR. To support the wakeup feature,
> > follow these steps:
> > 
> > - For suspend:
> >   1) During Linux suspend, when CAN suspends, do nothing for GPR and keep
> >      CAN-related clocks on.
> >   2) In ATF, check whether CAN needs to support wakeup; if yes, send a
> >      request to SM through the SCMI protocol.
> >   3) In SM, configure the GPR and unset IPG_STOP.
> >   4) A-Core suspends.
> > 
> > - For wakeup and resume:
> >   1) A-Core wakeup event arrives.
> >   2) In SM, deassert IPG_STOP.
> >   3) Linux resumes.
> > 
> > Add a new fsl_imx95_devtype_data and FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI to
> > reflect this.
> > 
> > Reviewed-by: Han Xu <han.xu@nxp.com>
> > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/net/can/flexcan/flexcan-core.c | 49 ++++++++++++++++++++++++++++++----
> >  drivers/net/can/flexcan/flexcan.h      |  2 ++
> >  2 files changed, 46 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> > index f6e609c388d55..fe972d5b8fbe0 100644
> > --- a/drivers/net/can/flexcan/flexcan-core.c
> > +++ b/drivers/net/can/flexcan/flexcan-core.c
> > @@ -354,6 +354,14 @@ static struct flexcan_devtype_data fsl_imx93_devtype_data = {
> >  		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
> >  };
> >  
> > +static const struct flexcan_devtype_data fsl_imx95_devtype_data = {
> > +	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
> > +		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
> > +		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI |
> > +		FLEXCAN_QUIRK_SUPPORT_FD | FLEXCAN_QUIRK_SUPPORT_ECC |
> > +		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
> > +		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
> 
> Please keep the flags sorted by their value.
> 
> > +};
> 
> Please add a newline here.
> 
> >  static const struct flexcan_devtype_data fsl_vf610_devtype_data = {
> >  	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
> >  		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
> > @@ -548,6 +556,13 @@ static inline int flexcan_enter_stop_mode(struct flexcan_priv *priv)
> >  	} else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR) {
> >  		regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
> >  				   1 << priv->stm.req_bit, 1 << priv->stm.req_bit);
> > +	} else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI) {
> > +		/* For the SCMI mode, driver do nothing, ATF will send request to
> > +		 * SM(system manager, M33 core) through SCMI protocol after linux
> > +		 * suspend. Once SM get this request, it will send IPG_STOP signal
> > +		 * to Flex_CAN, let CAN in STOP mode.
> > +		 */
> > +		return 0;
> >  	}
> >  
> >  	return flexcan_low_power_enter_ack(priv);
> > @@ -559,7 +574,11 @@ static inline int flexcan_exit_stop_mode(struct flexcan_priv *priv)
> >  	u32 reg_mcr;
> >  	int ret;
> >  
> > -	/* remove stop request */
> > +	/* Remove stop request, for FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI,
> > +	 * do nothing here, because ATF already send request to SM before
> > +	 * linux resume. Once SM get this request, it will deassert the
> > +	 * IPG_STOP signal to Flex_CAN.
> > +	 */
> >  	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCFW) {
> >  		ret = flexcan_stop_mode_enable_scfw(priv, false);
> >  		if (ret < 0)
> > @@ -1987,6 +2006,9 @@ static int flexcan_setup_stop_mode(struct platform_device *pdev)
> >  		ret = flexcan_setup_stop_mode_scfw(pdev);
> >  	else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR)
> >  		ret = flexcan_setup_stop_mode_gpr(pdev);
> > +	else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI)
> > +		/* ATF will handle all STOP_IPG related work */
> > +		ret = 0;
> >  	else
> >  		/* return 0 directly if doesn't support stop mode feature */
> >  		return 0;
> > @@ -2013,6 +2035,7 @@ static const struct of_device_id flexcan_of_match[] = {
> >  	{ .compatible = "fsl,imx8qm-flexcan", .data = &fsl_imx8qm_devtype_data, },
> >  	{ .compatible = "fsl,imx8mp-flexcan", .data = &fsl_imx8mp_devtype_data, },
> >  	{ .compatible = "fsl,imx93-flexcan", .data = &fsl_imx93_devtype_data, },
> > +	{ .compatible = "fsl,imx95-flexcan", .data = &fsl_imx95_devtype_data, },
> >  	{ .compatible = "fsl,imx6q-flexcan", .data = &fsl_imx6q_devtype_data, },
> >  	{ .compatible = "fsl,imx28-flexcan", .data = &fsl_imx28_devtype_data, },
> >  	{ .compatible = "fsl,imx53-flexcan", .data = &fsl_imx25_devtype_data, },
> > @@ -2311,9 +2334,22 @@ static int __maybe_unused flexcan_noirq_suspend(struct device *device)
> >  	if (netif_running(dev)) {
> >  		int err;
> >  
> > -		if (device_may_wakeup(device))
> > +		if (device_may_wakeup(device)) {
> >  			flexcan_enable_wakeup_irq(priv, true);
> >  
> > +			/* For FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI, it need
>                                                                       needs
> > +			 * ATF to send request to SM through SCMI protocol,
> > +			 * SM will assert the IPG_STOP signal. But all this
> > +			 * works need the CAN clocks keep on.
> > +			 * After the CAN module get the IPG_STOP mode, and
>                                                 gets
> > +			 * switch to STOP mode, whether still keep the CAN
>                            switches
> > +			 * clocks on or gate them off depend on the Hardware
> > +			 * design.
> > +			 */
> > +			if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI)
> > +				return 0;
> > +		}
> > +
> >  		err = pm_runtime_force_suspend(device);
> >  		if (err)
> >  			return err;
> > @@ -2330,9 +2366,12 @@ static int __maybe_unused flexcan_noirq_resume(struct device *device)
> >  	if (netif_running(dev)) {
> >  		int err;
> >  
> > -		err = pm_runtime_force_resume(device);
> > -		if (err)
> > -			return err;
> > +		if (!(device_may_wakeup(device) &&
>                       ^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Where does this come from?

include/linux/pm_wakeup.h

static inline bool device_may_wakeup(struct device *dev)                                            
{                                                                                                   
        return dev->power.can_wakeup && !!dev->power.wakeup;                                        
}

Frank

> 
> > +		      priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI)) {
> > +			err = pm_runtime_force_resume(device);
> > +			if (err)
> > +				return err;
> > +		}
> >  
> >  		if (device_may_wakeup(device))
> >  			flexcan_enable_wakeup_irq(priv, false);
> > diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
> > index 025c3417031f4..4933d8c7439e6 100644
> > --- a/drivers/net/can/flexcan/flexcan.h
> > +++ b/drivers/net/can/flexcan/flexcan.h
> > @@ -68,6 +68,8 @@
> >  #define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR BIT(15)
> >  /* Device supports RX via FIFO */
> >  #define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
> > +/* Setup stop mode with ATF SCMI protocol to support wakeup */
> > +#define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(17)
> >  
> >  struct flexcan_devtype_data {
> >  	u32 quirks;		/* quirks needed for different IP cores */
> > 
> > -- 
> > 2.34.1
> > 
> > 
> 
> regards,
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |




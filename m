Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154334EAA22
	for <lists+linux-can@lfdr.de>; Tue, 29 Mar 2022 11:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbiC2JJ7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 29 Mar 2022 05:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbiC2JJ6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 29 Mar 2022 05:09:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1711DC2E
        for <linux-can@vger.kernel.org>; Tue, 29 Mar 2022 02:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1648544894; x=1680080894;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iiBly4Au/suhfIA8cvjFAd2jIydac2le3HF513GNy5U=;
  b=sKnc1DtvpNF8kBqlbzzV+ZSO+tx9G0QdnHCzcrTM0XkJQHHkhSeVuYnE
   kGUYDpajVsUKBoAdh4JtD374GijfvBfuIzMJ0EGBHSHiP1yV/jXyZlZdX
   2TDrbkgHRbdiVjsUlGIvMuYJm1bA3q/sZlDhJh48SiBv2d/NTZT7DDxtP
   2YqHi7WI3dyCvgdomh+YNpgBabJh4GvB1yM97E3E56pGrDCzOpc5QV8zA
   sF5i8Ei1HJ2LxJaq5KBVlNqoEcE7l3PFy8wY6XK8myHq5xXauLS9Umfuh
   FnnOXu4TYwb53BJl8CKA05a5E1p+GJJPkvPesjrre/D4AcS2J0/URCYD5
   A==;
X-IronPort-AV: E=Sophos;i="5.90,219,1643698800"; 
   d="scan'208";a="90471520"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2022 02:08:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 29 Mar 2022 02:08:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 29 Mar 2022 02:08:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hb56iMf/49K3qWyyIQdLzDhZX5Diqm8RlH76ppsVUYWYt+AIJstskNUFQTmSt5eIfRIU2WkhrqZQUcpV/WejQNWg40YFRH3N/t5mLruE2A0sl7Zs0FKNBjWg6cvenGesMoTV0MVPUZiM+PBYvB2Du522wU4nagbzm0xhcNdVxc6/u/JgUGge7iXTlvCXqS/sFnsdNUI3IzP2Q1uK/4axwbTgRCwmC5RMQmV15qd1SF6aJ3jqkS4tfa84b/SshPHNYt3THV9lpN8NpBKwZkUFVqAjgbK+8oykY8g4nKZKlOwcNaMltpg1UkDLj4C9Rt/MVwEqAB9Isf+/H87NjQqEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiBly4Au/suhfIA8cvjFAd2jIydac2le3HF513GNy5U=;
 b=fasgGQZteUcDBfWKdWJRzifzpvGHdQMU3aS+FOfR2yb77NeKhlklAE5bnud3pDni31GVlI9S/qi7Q9VTM3TMPmK9ECmOmaSins4ThU/Ty8HuUw67WpVESsp9BKCNQ5v715S45p8XAvHjsytzZbL+IHmWRlJdZVNuCMD6gdCPahBqn/w626HD1K8GpCYCSI7YOVXkQp73vzKtBVj9nQlSJaoRbHKQ+h+Wf3xmN3r8zcmVwujqPvOiGMPnxzJ3IycCli/JbwirJ5mAG5SoAB+o3+Eqe2o+gfUe0qVVHvBa80mOCMj2gW4YrS/Wl4cYiqbg5AA7IhaCzPxibEKJjP+neA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiBly4Au/suhfIA8cvjFAd2jIydac2le3HF513GNy5U=;
 b=P6KyE1BlMMKiVukumcbLETH4RLuQ9OL1rYRvfi7UBi0EzlrisHdlpl9L6qTHQ/58x9gxCZeuRM5KfAOLrUVyFx6GC3s7Azusn0LsO8A5lkN4ITvV0f10kpCbYAOsYuO2vtgU3CPaVVN7OdYFRnVkPbFLAB31nwZoaLOV0gUteqY=
Received: from DM4PR11MB5390.namprd11.prod.outlook.com (2603:10b6:5:395::13)
 by MW3PR11MB4730.namprd11.prod.outlook.com (2603:10b6:303:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 29 Mar
 2022 09:08:11 +0000
Received: from DM4PR11MB5390.namprd11.prod.outlook.com
 ([fe80::815f:c1cc:e819:cda6]) by DM4PR11MB5390.namprd11.prod.outlook.com
 ([fe80::815f:c1cc:e819:cda6%9]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 09:08:11 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <mkl@pengutronix.de>, <linux-can@vger.kernel.org>
CC:     <kernel@pengutronix.de>, <manivannan.sadhasivam@linaro.org>
Subject: RE: can-next 2022-03-13: mcp251xfd: add 
Thread-Topic: can-next 2022-03-13: mcp251xfd: add 
Thread-Index: AQHYNrV85eXBoW8fO0uqUGXLZ/3mU6zWKuHA
Date:   Tue, 29 Mar 2022 09:08:11 +0000
Message-ID: <DM4PR11MB5390EB2EA594AFC4721017E8FB1E9@DM4PR11MB5390.namprd11.prod.outlook.com>
References: <20220313083640.501791-1-mkl@pengutronix.de>
In-Reply-To: <20220313083640.501791-1-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c57091c-8a8a-483f-0fd2-08da1163a657
x-ms-traffictypediagnostic: MW3PR11MB4730:EE_
x-microsoft-antispam-prvs: <MW3PR11MB473075636F9CFC6BE91EAD99FB1E9@MW3PR11MB4730.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FDpucjwQ7rdML5c96rxc4K01mHxWek3UyeLbyW60U/Fhmxw5FM33HXobo8ZYGogxi0PPNjkX67W+aBha8kGAJuWawwGXiDSM2iQBOqv0hMKggR6kRTDvplqlBwUmAwLes1xMhA53oKsH6ZoikWj7b2D8jYl7opGide4Yy1JLMNuc38tLsMXISPpRajqmzRwz9hBcfXonmAqILAZeFdkOg9kazGjXWLiKVZjXEuF4tmrLlp/ZqO+GIA/K6KfelkqunmRTwPcDdDv/IB3xD/t3ptzVrDlmFcNoW0/c7tgT1xHvHc5zY896uqUIt/LXkP01graJXJUOTgkrsNZE7kJ4lCmkmmKigZEDAoLfeUJSugs7QEh3rtPYPYjzGsyiQ8+vPjj2jVQtS826+6KNoW+9VlII3ZDSsKH8/8J0KB6h9MCfmPsHtUZ1MNy1bWHOSVKDYZqhuXfFIZSwFyKUq+Yz0ibtg5sh+7XrqouMES755JTybHuYmtJlFDJDh0tB+0dxeedAk6GanaWCQu8aXM2DIMxbrZZeY3IeJs6xmpNdUhbTFUQGW+YaYJ/Qzt/Dk/KbiOT4keU9DSGNvzXNiBlZ2TiMQOADsa7Icd9ugWJMRPCjCJULxrE121XfTPRmBHKxHRZc0TwPwZNhM4Frz7lIdYOccE9mAVG24UvEzq2HZtoo3iyvUez4UloHJH3c6K/O6eKbox9H6zePP7Hcpp7kMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5390.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(508600001)(26005)(316002)(2906002)(186003)(4743002)(86362001)(5660300002)(33656002)(55016003)(52536014)(122000001)(4744005)(9686003)(38070700005)(7696005)(6506007)(66556008)(8936002)(66476007)(38100700002)(66946007)(71200400001)(8676002)(4326008)(76116006)(54906003)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G7q4fSbZwzPxjDvgv4GX+IzMLmgnIxDhivAp9MgvwWByHMFB/vKeGSe919+r?=
 =?us-ascii?Q?ZQypW7xIQTSeqMeoOmTSlySJvc5axeBXhRJNj43numycdFjySNPVg+FW18i0?=
 =?us-ascii?Q?nm1V6t6YgW1D6jR/KyLyjeB0OrLWs2SPNl0k3W9rvrv0fd/ygkXok/k/3dSk?=
 =?us-ascii?Q?Ib3lCSjcEeK32MPiTeMNT1MSYiMP/j15FL4UVkkZ1Kifk/HzVKIioxnY+ugp?=
 =?us-ascii?Q?9u0SO1N5ngfOAY12qkiTMjfrOdZBqQZzoLysP7pWqsgRSEwcscHOtLw1yRkO?=
 =?us-ascii?Q?MrIrWJ7kLF8j2RS1rw8+zEv8JPXHuFggTu9BG2f1S8JIrUkLqTkZNZ8607rA?=
 =?us-ascii?Q?JtKoE1QmTUqWgUAk26OhZZkdKl2e/j+E6zZ2IVRO3Y++eWde93ST4vLNbdNK?=
 =?us-ascii?Q?CwJvfFODvdnnL8lGkfZP9xL57hX8i8aC5RfuCOh5GPFtuj7LbqoLUUfJKSRZ?=
 =?us-ascii?Q?CEMirFDMVOVNlK4ZjfgMS+cqhe81Qj39Z57MxasnPriF0wYV9rV+U2uEm+o5?=
 =?us-ascii?Q?d5S+vsEz2q9kf2jKq59CrYozty2WupMvYLzYLMTAfp2pqs98Co7dMO1JDJf+?=
 =?us-ascii?Q?GZ2ZW0/WeSaHK59JkL9CVb7tNtX7Ksz4R+KOYb1H55TZeUyECG2xvAGmSRpo?=
 =?us-ascii?Q?gRxfagq1/0c7fOo1hwpJFRB3P+rOqCP8N+qJYbJ99NqKuf1+ohJihfWRIAXK?=
 =?us-ascii?Q?R959c6LVDC2slPY/6Sd3ZuHw3DB/0GtZtHqnqr6VJ0W89HfTxRzU+c4t5IEd?=
 =?us-ascii?Q?4ESXAB6xJ3l66vmDWC89r9I1y/amdwbLDlYVle2WhOHpOXfBXS/WKn8mbrRX?=
 =?us-ascii?Q?OdOhBeBjgXaFJm2Sa88wzkSOZrf0duy0shrcidKekQz2YadL7Wung0IdC47f?=
 =?us-ascii?Q?ryY6OvG2+DsvER9IRImYOrpTuUHzeY1PG1ysHH8XZvCylcOW20cHiX18x2Rl?=
 =?us-ascii?Q?HExV/MtxijfcQ6swV2S2imD++zTctRiYo5ktMrdSnhrQ1svA+W+ru+PnnxlA?=
 =?us-ascii?Q?05jjVHblMd3KDs4U+P2GJph/71/dfpR8ErJHzdxTMtlKV8mbviJUgSBwiREF?=
 =?us-ascii?Q?lwMWIk9l+aX2TMr5gZoEbvtZ9pch5IhPCS5qOPy/tiOc//PGHPSrwXSApzwW?=
 =?us-ascii?Q?lrGCtaj/L3rk4eT9j2Z/K223TWS0GTamQ7LSVTV42sO0YJ1aPd8ktxpX9aLW?=
 =?us-ascii?Q?aZtgt3SptqVLiT2w2yZXvv62JL3/6PuAJcvxQymm9y0TLK5mA8LZ+UlBBd/D?=
 =?us-ascii?Q?dK/zWAm8J5K4QJbh7cyCSBa3q5CautY8XO0ycdkUaDE/qL1OaWRRK9AO/IyC?=
 =?us-ascii?Q?ePXDfHrAP+xrPmNgvMyM3BAcGsbH3QjVtttyjJ+rFsW1r/2DbsVSoPMjepER?=
 =?us-ascii?Q?1tg7kb8rHcsw7VY/CvtJeN2FdCZiIDhTWDYF2KO627Wj9NCEQ6wnAv2mnYn0?=
 =?us-ascii?Q?/1Mcqe9yw6SZCwtkpx7ekT4Ng57rFGjaPkIRB7gGlrvIWbm0+yyqax6xXLIu?=
 =?us-ascii?Q?8iALlOvHbeLEa0rd67HWD2E0OQWyvU4hzcN00j0iTT9azwRq4cgQXmJAoFhL?=
 =?us-ascii?Q?BFDVGJ11nGnCaniqsmnLyPEDIlFaT6F2ZOoVIO9H4pEZLrAx7tkF5OZH5pLZ?=
 =?us-ascii?Q?7XkynFgkQgMbSiHPSuEcO2R/in1qQkxDKX08QKqKk9kdozBtSthtEJ2ZAqHZ?=
 =?us-ascii?Q?3BeVb4zBorwmLVbrBw2V9bhmHTockGUtOp/KRyN/aYNklyXBTPPWHtizgayw?=
 =?us-ascii?Q?X7dMTLn2LZ529QMuK4Kz9cR22O9KcEo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5390.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c57091c-8a8a-483f-0fd2-08da1163a657
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 09:08:11.5723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HeX93UbnMIq+hQnMASohkKTM9thG65S9GLW9xZdhdUGMkM3yRnS45j5eUVHY9gubK1hgRZMOZINCovNYtKrkgFQJaq0j1vzeHphD2TBmdj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4730
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

> From: Marc Kleine-Budde <mkl@pengutronix.de>
> Subject: can-next 2022-03-13: mcp251xfd: add
> Hello,
>=20
> this series for the mcp251xfd adds IRQ coalescing support.
>=20

For the patch series: tested-by Thomas Kopp <thomas.kopp@microchip.com>

I'm fine with the default min values for the FIFOs changing them didn't yie=
ld a significant improvement.

Thanks,
Thomas

Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC4F53DA53
	for <lists+linux-can@lfdr.de>; Sun,  5 Jun 2022 08:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346335AbiFEGA3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 5 Jun 2022 02:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244087AbiFEGA2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 5 Jun 2022 02:00:28 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835F220F71
        for <linux-can@vger.kernel.org>; Sat,  4 Jun 2022 23:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1654408825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N7B611lPNkMX+J/g1gIA1ubVXnH+aDEmdnDvUCS2SVk=;
        b=edHp2uAjG3ifmX/b2GSpWpzSF57e2e8dXOb1wQtCs7ukIJvbfRZzrwDlbLTNm4EcQVCFBy
        VQkZAZStryI1CVAgkas171c3eC+Fh6sPklMvISYIP54mP70X3si+AewrP6e6N2EN+4741e
        6QtePxtxonppOebJ6LWcmMYZm3MAC+8=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2050.outbound.protection.outlook.com [104.47.6.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-4n7UQPgyP_6NfQcx3P2iTA-2; Sun, 05 Jun 2022 08:00:22 +0200
X-MC-Unique: 4n7UQPgyP_6NfQcx3P2iTA-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q06PHzRDL9HuOrFpwA93Ops8IcbPhiMRYzK4MD+lEyxnB45cLnRnpU+wsOLdnxAO3Io7SAg6zZBU5if1S5xyaz1TbGKHO2/Mtm7V25zraIck4eOcfsA6S7DRaDcBcBD5T6lQ+wCogrTfy2VD73vW1fQLTNA1Z3AXmOc+onQv3aVXM6nzwSOvfylRDpMC/z4thZPxUo7JPywKquRG3HceW4bNBR9Hw3ku2yAaTeZpVpQkf1oUFdNmFVKsnbPp+5gPmDszF1j2slNP0jYQM0eHQJrqOGpDBQUvv2kfn2+kh5bVAP1wZsJ+acGi7COjp/kJPGiSugdtGzG/c7G/AG5H1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46CO14ioM9ZyNUU42AeWERAdr6YtL3jcZq140umeNk8=;
 b=iSJOy4fWeLmOb1Cwo9/UtN5T5O+7iVmkPK4uL0fwJlSXB90usv9x6hS0Kj6/lttOU86EaN3XB54zks1nak4/vI7XXrlQb+/x6n3BbumynIyU61KfZY945ZZfymHV0y3uefMlR/cTN5iHjl2KWjHR2wIQkIDNn2WUOh9WVmdESpjLOe4dQKYLhlWR9cRssH9UBrdk0Uryo2CqXPueRbnevrRwtFpGok4V0NhuDv6hzlLQynJv5JczLSPcggsAFIhUjRLNCuyWpxZ1yJ7NQ51KV817+L7yTRf3eqmZNWyoBJFvipdyiiPP7Dxfrj4p6p3oNWOawiAigjXNu5reEWSKyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by DU2PR04MB8935.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Sun, 5 Jun
 2022 06:00:21 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::19e2:fafb:553f:d8c]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::19e2:fafb:553f:d8c%11]) with mapi id 15.20.5314.018; Sun, 5 Jun 2022
 06:00:20 +0000
Message-ID: <a57f4af7-3fbc-0853-dd9c-b80b2425b4f5@suse.com>
Date:   Sun, 5 Jun 2022 08:00:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH] USB: core: urb: add new transfer flag
 URB_FREE_COHERENT
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC:     Rhett Aultman <rhett.aultman@samsara.com>, wg@grandegger.com,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-can@vger.kernel.org, linux-usb@vger.kernel.org
References: <alpine.DEB.2.22.394.2206041003320.1657582@thelappy>
 <20220604144157.208849-1-mailhol.vincent@wanadoo.fr>
 <YpuLGkPcXrM+Eiwj@rowland.harvard.edu>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <YpuLGkPcXrM+Eiwj@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS8PR05CA0027.eurprd05.prod.outlook.com
 (2603:10a6:20b:311::32) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6869e44-a572-4f4a-058a-08da46b8ac4d
X-MS-TrafficTypeDiagnostic: DU2PR04MB8935:EE_
X-Microsoft-Antispam-PRVS: <DU2PR04MB89356925D973FE806B4DA878C7A39@DU2PR04MB8935.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6AUyeIraJD8vtZhbC4uUm+GG0YO+EJTupTlOePOzZdv8G4do4hOuVdxx6eLZLysAtiQgE+/ieTjHnpS8qbWN37C1aWmPn2tB5eFvdOlvjKQrsyX49vF51AtMxyHqeFyyCXUewx/2XMHwLApl8ksph7iezV4br8+dTYGlpfFIlRi89uSFeflHEadJUBIK5tyCNslNjDBhQ+DF+q0KHxplWlDRVLVXpSwsIt13JQInQ1Ah6/PWPeLXTk6m7aU/7VVUGOHwj48nOeVcNdPUiEfSLr2wGQRJNpXT64KpO2fT1zLB+lmftjc7aS4XCLJQl1ET6WCukS31RyHhwEFAA/wG3X5Js396C8V/ZTknt8ExoCbGSQoir2NpZrBkdgEsDAJogtCgpD5Bbpl9/HDwXiYfZTB/2P09b5apbAEQCcszrOerWMPOYHFtb/aR8T6raJJYzHt5hkE20iyHRDgLfRtloqe1vdX1ILfmhSFmsVJ3d4a38X/T9I27WUYE4SkoAHJRmREXXpKz1E59iL9+QNLq5wibIFNH6mgavenpqvKgUIr4jgE70DBQb8aioOqGATfkJOzGW2+b9N0rq4rHoFwLc9NnQwsSowntMBgPYSyAwffUwhsKtogZrcvOx3YvzFeak19augjI7omK9DG+GYq3FpRvZih3kwkLmpPOADSegHseugI2w7yK619iFh7SJloxgalonnazWqV5yWn9cHYfueKvKVWi5LWI9QgX0UjLzw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(54906003)(83380400001)(66476007)(66946007)(38100700002)(110136005)(8676002)(186003)(31696002)(508600001)(86362001)(6486002)(31686004)(6512007)(5660300002)(36756003)(316002)(6506007)(2616005)(4326008)(2906002)(4744005)(8936002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u6n3vPPyzPyot6fGJINmSp184EayGo7VR7vCHRAeIioKR1oHHjuFDXgcFLXX?=
 =?us-ascii?Q?Kcjb66SbRifJCqjbmPUOcvG/YoMmcKeg3Vm6IiFR/az5YKkVIg1J61cxOylP?=
 =?us-ascii?Q?OZbm86IZ/EcsUYHsE80vgUmYm7o54svWpOfTZ1/cpmMCJTjagRR2aj3+YTF4?=
 =?us-ascii?Q?VqpyWaAjFn2NCqXhcSfIswGiTRmr40oqUegaYzBACDMZlYesV2vUheTyidHF?=
 =?us-ascii?Q?Kopylx1hSaIRJNBAnC2DX1AGf1MwVpqMv+iFodszJqH6Xn76OmRw4NbH/FjI?=
 =?us-ascii?Q?db/CisFo5TktQwh3GyYQjWnNoDBJv1iwZqq+ryK1TQJN9nI390aO3wzWx7P4?=
 =?us-ascii?Q?ZUgfe5ly6PTX40qsuQj09ofYl3hBo1IRz9j8Q0Iiu6x3wIxNu8fYhGE8sLeT?=
 =?us-ascii?Q?AlCbb8FU4DZQUfWh6vv9OmWwBad/MLokGY2eww/d1nKy6F12qsi4vQuCzHsG?=
 =?us-ascii?Q?NwojeSgDARJ11i4S6lJxMM22zXqkZ2KXL8BhuaZ8v8cLUNbA6Hb11nVDkgAA?=
 =?us-ascii?Q?Fe1nXfLIG8GNLH+9qR8lKwASB4ZWF7FSgR1D6ydCpAGeXqpcvnQ7ol928O6O?=
 =?us-ascii?Q?TlrXlFTzPbvCZuzkfJ5tDcAS7Mj2LMdJDMWUILDkzkKUT34/N2FYZVI32zjO?=
 =?us-ascii?Q?KamDOUZrtZbsfNWKUlRi8h6l0BsChUVSla4s4DkcYwOP+VuIFXeEO2PEL1VN?=
 =?us-ascii?Q?UbVSSF1n36itkgkwTd01fiAbhG8zHXl4RhxljB8OhlWZrfUkiAuntWoU5NEq?=
 =?us-ascii?Q?te/RMnXuZ75YsnxjVqiREAcw+mCmZ0gKvivm1QtN15U1fizLsJ5OkVeEIfT7?=
 =?us-ascii?Q?Jnrtd0cC6ywLcxlSc9skK5l84U7GaYNRmGqxT4JO6iZWqiqEjiDItQ8ZsgJB?=
 =?us-ascii?Q?FdA2k1j68kRur6e1BGG8xEPWrbBZ9a5CS5elIVelaSfO6e3v+k1xgUnXL6Qa?=
 =?us-ascii?Q?MDH4h5Ct5Pyq9tmbwJ+NbdKLfyFrT+W+2b3yTRTZSECNgZdHyOPAH/fHvXLS?=
 =?us-ascii?Q?SQ6hopue3o99hX6Wdj2hxNkz6xz7tuPC3VBSYoc9fB0/hEZoaAgquDHQd+cy?=
 =?us-ascii?Q?AzhagQNWFQEYlZEcE0cZ0hSVPNSQcneMweYDN9Fr85qtx7TILGlmQ8Ffn/Vz?=
 =?us-ascii?Q?nYKRiw9MhoQzLDFX1WnWI8be6Vd/QVQIFiJsqImOl66yuTUXrZt20W1yPsA+?=
 =?us-ascii?Q?epT8zi9d3oiu8h3w+30xB3OKruZmLOBIvS6ZHRzoecyYmvw8J+H/b1+GML96?=
 =?us-ascii?Q?K6I8m14WszQLokOT/EoVQqFkuEDyItA8oG98ZnTBqTxljHRmxQJf71C1eURY?=
 =?us-ascii?Q?QsaOtLmaRZ5ysIIQ5RGpBYJG3fNNd9MC9H8ckIXqCZv1rXwgy2ttnOfutdcG?=
 =?us-ascii?Q?9OEPFEeTcIh0fuyPyGOVUPWAzt9pVHQZjSltR7jQDdGi2TxTjvAsn3h06BBF?=
 =?us-ascii?Q?jk72VKPUVfLoBg3tAZT8ZBwVfCOkn7tLlyBsjRj08m599ByAhlNcGmiVX0dJ?=
 =?us-ascii?Q?v8ByFSaewj5j8w/IF/0CIncQ+Eisr+ZyzNSI+XdlpVhG4lwzy3Iu7MOo7wP2?=
 =?us-ascii?Q?Y8q3SZsIe4vnNQKCynmzBjUH6PU6VyA3SotIESFbsiqVJCmqKKD4JquxRidQ?=
 =?us-ascii?Q?TerTkx9meM7GUj+CcYRbBoPzINZVmRnelFDTfW4BjF6sKRmqbOzyCbUAQfFX?=
 =?us-ascii?Q?+jGSB7Qm0hubMjY0nSsThTcQDL0j4ygVlIxsFyq+iLkiZBOoGunJLq5mM66c?=
 =?us-ascii?Q?tSGpnM/FK4l20B9CC3p7jwl1BviS+6tqyxDhsc8dzkgU5q332h7tExJiPrF4?=
X-MS-Exchange-AntiSpam-MessageData-1: siDf+ovuXKjb+Q==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6869e44-a572-4f4a-058a-08da46b8ac4d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2022 06:00:20.6408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZraNuHdDvN523waPBjFzTkGHyQBW0k8HCYqOBOHO385vUVHNZXW5Lw2J0VX8wwU7rCd2c41MRdSC2asp7GbWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8935
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 04.06.22 18:40, Alan Stern wrote:
>
> I don't see anything wrong with this, except that it would be nice to kee=
p=20
> the flag values in numerical order.  In other words, set URB_FREE_COHEREN=
T=20
> to 0x0200 and change URB_DIR_IN to 0x0400.
Hi,

but what sense does this patch make? You use coherent allocations
to avoid repeated DMA synchronizations. That is sort of incompatible
with the notion of discarding the buffer automatically.

=C2=A0=C2=A0=C2=A0 Regards
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver



Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2511253FA5C
	for <lists+linux-can@lfdr.de>; Tue,  7 Jun 2022 11:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240194AbiFGJwM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 7 Jun 2022 05:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240364AbiFGJwB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Jun 2022 05:52:01 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBDFE77D5
        for <linux-can@vger.kernel.org>; Tue,  7 Jun 2022 02:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1654595403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yVd/gVU65vJ0/hx+3D41i6//ucBNBP1A4AX4UJQF8mc=;
        b=g4vO8wK6Ij0nWyMmqZEnJasGhI70NpEGeKGiIy8Zpgd4+N3i1gyaCg+IuyyDokf1sFUBgS
        5gVupLy2TuyDjcd/QA3HAKlIgyngDIVrLL0zBT0ThjG/j7NJtoFdapS3Kb/irfExJr2XP1
        34S7XS6RKQVwxXHOU5MXUEhCr8jqTaw=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2051.outbound.protection.outlook.com [104.47.8.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39--9Z7yP3BN76EtaQ1_RCQ5Q-2; Tue, 07 Jun 2022 11:49:59 +0200
X-MC-Unique: -9Z7yP3BN76EtaQ1_RCQ5Q-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LazWHD+9xTkUfDjg1/qQ/2f23o5yzPYQcgfctPr1QFGaLV7x6NTCkpXzzZ/UkTVZUGmooirtnK0rGFAohafn2Vl1Xovwx1DwSAZZZUNcnIY69aPH80JVfCWqtrVOR9BCFvuin4F+9MlBf+1IpgjIQxesoqQSAuzW/WIzmAyx99wEZp9SQoi0YaNmA3IHZfK6FP24gqBuQFDe0L1IE4FdzBQdGZdVY8IUEEFep15pzoSOMvBr9hsndUjzkPmQIPgTCLFpUUm+t6V274o1OCIILYS2h0QG5qD+gb2Tf5HjbKy1+4ikk0+w9CxyW8roZgp5U0s4uAAbYxgsg1KQlY5/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmJRHRWciqmCVIiGpcdqrc+GknpaBq3ELrtyqCARtiY=;
 b=N5DPeFGd0i4AjdAPOk7YOsVXJXKlnzqYz8vEPPex4uO2pFIoigbIjdNCvqgzjNXvlEssTt+YYGzfAFUfdRq/L6G/n863outhK06zhKfNiV2jZ4XaDEFszmdMJLb9AeGhoKuv+cD+jnLq4jvzlbod+5eKBTxcaK41SlvDCtXQhrOtXxRIX0afSd8bA10JBiYrUcSF/W+/AVPPXECzm0yFy2sghJTBLD0tAtEJH5ylbDtVa4LA74quY5glCZjEJgG/kVIVtqsieURWemvBCkCi1iz9tUuzRlQe5k2wtRnKCxTH1TkucVbaUKHIga9jYZBBHBwdbDBnupOZCvy542lc7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmJRHRWciqmCVIiGpcdqrc+GknpaBq3ELrtyqCARtiY=;
 b=iLf/Z/cXg7206NdgJzdnAKEJi3TNRnT2wmQQmKJl7eycIZMlw1n8erbun4UlBTauzbfkiB3s07tg9o+AUfGafJE49USPfYM0zZzMKXHMBaUqsJfhaETsMyU4IYkc8Ucmd27PEHDZqS6NQmn4qp+JtUfUHQOaJa+CpkxXMsYb42SygQEAxJwPywIq6GcyGp66t+umCyuttevhRY2iJpo2I3GKjZXIm8jqoA+hPXsGmZbXRY3+YHE6wp7gOBVj6CqFQkKmy+3KcX2mmMHtAVudc8zTl/kU43Js9HqLaY8KhM3TGlZZDmiWUhoDM0+O2edWoPU8dsvoKKtLMpKXL27D0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by DBBPR04MB6316.eurprd04.prod.outlook.com
 (2603:10a6:10:cb::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 09:49:55 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::19e2:fafb:553f:d8c]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::19e2:fafb:553f:d8c%11]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 09:49:55 +0000
Message-ID: <66b14321-667a-46a3-27db-cb8682bd5476@suse.com>
Date:   Tue, 7 Jun 2022 11:49:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH] USB: core: urb: add new transfer flag
 URB_FREE_COHERENT
Content-Language: en-US
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Oliver Neukum <oneukum@suse.com>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Rhett Aultman <rhett.aultman@samsara.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-can <linux-can@vger.kernel.org>, linux-usb@vger.kernel.org
References: <alpine.DEB.2.22.394.2206041003320.1657582@thelappy>
 <20220604144157.208849-1-mailhol.vincent@wanadoo.fr>
 <YpuLGkPcXrM+Eiwj@rowland.harvard.edu>
 <a57f4af7-3fbc-0853-dd9c-b80b2425b4f5@suse.com>
 <CAMZ6Rq+6z-Nz=Nao2u_=LOC5QYF6KBjy-HdK1x41O4zo1c8HHg@mail.gmail.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <CAMZ6Rq+6z-Nz=Nao2u_=LOC5QYF6KBjy-HdK1x41O4zo1c8HHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM6PR08CA0014.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::26) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1729d085-db83-4577-960f-08da486b134c
X-MS-TrafficTypeDiagnostic: DBBPR04MB6316:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <DBBPR04MB6316E8130C6774C5DD09951DC7A59@DBBPR04MB6316.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RqjYFWhsSzPSCSOrRnTP7Zyln2HxFJHtAJQeYmGlCILTe7+KYf8QBCezW8LzoMzkosAsjdEsUDOHdzac8hA7aY+zu9htgOc5OtkqViRdbdEK4CCb21wXIXtZHTyMoaUDWmD7s2t2FZQfcAlLxyCjAawoVmmgUP1Sj9kfdZGWA69vPXCY8d+ZB5URJPXiinN+jwN1sv6Gdu6ABwfnHyzGXUcfQiWA6M7j2dUtl4S88GbXS79MURzWg38C08XMdtZv7QOGlzeVmbpdR3z2OjqW4asp6ljtehqxLDUvYXJJfLC7S2iHL8Twbps53Pzqqh4n0AcBzxs8Ozy28GDQLAQ4BLD9+sc4cKRkbWYQGstuuJtFRUQa9UWVtqG7zNRhS6okoBcUyzvg/tA4Pyu85RgZuzTzDb/6oBZemXWPZEHB6k9FrFZ2j3cFhXlJsQwhbUXohWK524g6J8iz//mbZFOHrEMJnsGa7ezB1ZIPmdM+1OuufJJHxjZTAn4jzloWR9enY+Vt0X8iAHEEWev/EGXMxafZRFIkLbppPYzDB+Ds7BgE6iQG0a+DN60A8M1nvIX7EP4vjWBiA1W6DFv/adelHFfEfY9o+FrAqs85RqqcqGq69zG1R1AYdU5mRFdH4rpVSzawlj4ri/dQMpGnMqqnAiQ+eKkbYNmQtSd8fEVdosmTfcXNxPssMc+bVCAO3I0SgTBJ467pGMFZTp6PccY0ODaVn5hM0EzlAYR6V8WSHSs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(2616005)(186003)(2906002)(66946007)(31696002)(86362001)(110136005)(6486002)(5660300002)(31686004)(6666004)(54906003)(36756003)(8676002)(4326008)(66556008)(66476007)(83380400001)(8936002)(6506007)(53546011)(6512007)(316002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?svxXf6AZDDqk4X0mkBa3BSicTFAMgaWoZo0d/bDmnRSA9wTlyQB4Wewd08m5?=
 =?us-ascii?Q?CvvHFmUXlY6eOyPQMHQj761g14wrEbButuJFuWSbfQuHXLam9enWN/SD2gdY?=
 =?us-ascii?Q?2DzXThYnWIyTyxLA4+9sfscE2Bg6ve30bOjyadWKijRB0eAT/TTPv079Eg5M?=
 =?us-ascii?Q?GeHyt8OSws27cDQY9EBl/DQdoEKMM74ktdI8cH6xcPfuwIzVQ+Z3hxTweATl?=
 =?us-ascii?Q?fVVyvbEkMxIZcp1p68j+YZZr7AO95t8HJO3tB6R5oYu6Xhdsk4s9HmfUDL21?=
 =?us-ascii?Q?iw7W9F0ucVLx32pVcM1ZBxZ0u14Gdw/RuVwNwNw3Omeeh+TAzayeW/JrHWDH?=
 =?us-ascii?Q?2B8fQISNnfoAMHHVwWpsiOtDeMNwzYmQLyn1akNyEtAg1AyVakKAJeVeL1Xr?=
 =?us-ascii?Q?QhUCjnD2UT/9Pta1ejh4Gv5A1c3967lGkm4E9LeyQt1gubLBXkQIDbXj4Zqr?=
 =?us-ascii?Q?h5rAtyXB+oFqsYCmTkGFncgCwR7xS5XfafA9SimRTmYJqditNWI9+B15qMX3?=
 =?us-ascii?Q?eog8geXb+nM/a7xOY2Kac/BvDYR5lXOgLxuKBsWz+ZDXoHKd4RERvl1pwbM+?=
 =?us-ascii?Q?UJjtyZxwY/CkV7aibwAj9HBB61dI8suwkR8xHckzGeGAkqslYaa/kqsk9dz9?=
 =?us-ascii?Q?Zzej4NDkUmYrxUnrv7Z8vXqq1+8u0yiM6/B77izTUm6xOyXRhg8NUL61KNrv?=
 =?us-ascii?Q?7pw8GdtwYLun7+sKVtulxBP+XDncg8R/BtMgQcawKfNwTW2nHidTW3aeQHxZ?=
 =?us-ascii?Q?GS/2tPVZY87JfdcbV64mhOPkp9X/dtxhLRH/IHaqtTbU5tADpRudRrvjI/Y3?=
 =?us-ascii?Q?Z4ixS06juSKYDUM3kjaEqOOXaZSDP+wEf/GJQkUynkRHdFXuxshXFDw3k6YH?=
 =?us-ascii?Q?omeCV0u9DylMEiFyjw/aEUneu0qhDStvaq5h4pbqsmgrpIdpeE95WM1oNCf4?=
 =?us-ascii?Q?sCC5kNxh7+rBdVoQBPXBlZ99QFHsDlQ+SNDiQp++ae/lYbXrUUZVrD96Yyi1?=
 =?us-ascii?Q?1wfqzjEmKG4AU92/HtAunkVWyzfX3rek1rLjdAoFNRpjGLY0yoeyLfXfF+Sk?=
 =?us-ascii?Q?rrF5fj0q3+lFHtCp61ULkWQ6GndiZq94Cdy8wD4y1rA0u9LhXhZCW3bXM/OX?=
 =?us-ascii?Q?1O7GhGpDK3txLhCMH5nhI+P1qIuOKOd8TLvIjrc7nZj2FstAqGi/wXWLDVcl?=
 =?us-ascii?Q?RAncKga1bZz+kmczGvpT0UrIjZz18eiunz8/wyQZQGASsNlVYNky7qp6tmwI?=
 =?us-ascii?Q?Zv3um6rXX9jTi7+waWE/UA6Y7ufKlJAJ+CYP/307hiBlWIHwYj2/eDqiUlqB?=
 =?us-ascii?Q?VmjCr1g3e2G7dLsJZA3b6fT1H/UZ/yFJUjPboBgTkX1V46n8OudRd1fMG2T8?=
 =?us-ascii?Q?O2xeiUm/WqsQVLj+0idmlaYlCp+oJAkNF1iqglpQoiENn2j1W8bxGbcYX+AZ?=
 =?us-ascii?Q?TfVIs2/RSLnCWEJHDFZWSzUDaZb7SEO5TYh8Ykoyu9QLgyor7YV52ejOj7UB?=
 =?us-ascii?Q?DYekDYw5+nvvskFzofVaQYJizk88CIDbaaY7NMLlFepakHNxviKMDwi7fxT9?=
 =?us-ascii?Q?DATq09Lb+TxKYphbT6gF52MEluIz22KhHbVhrux7BC64mbXfEONb3+N8bcGr?=
 =?us-ascii?Q?QCKXPt5+4KRC8NmWYzYVOH70RQ7Oe8rCp1jvXeh67Y0Vdmm51h7OyuGpsVnG?=
 =?us-ascii?Q?M4qb27/ZYW3HgIvIlosHUys+NzvqENz8x/8TWAEYRGLvsEKMn0/RbDZYQIbf?=
 =?us-ascii?Q?4PTCd69XYlNbfCprTS1vVG5K5YYXgs4MdlpwwOz1r89orPu0vVUI9fPPjBMt?=
X-MS-Exchange-AntiSpam-MessageData-1: 80WY3gAKzr+Y6A==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1729d085-db83-4577-960f-08da486b134c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 09:49:55.0239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCamLWblCkqYMtjiAcBCeLf9F7pNINuKz1TvrJM2ayMH+91ceesM0QrjomP+w2eADALVEaRx+xEb8GR50Tubjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6316
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 05.06.22 15:45, Vincent MAILHOL wrote:
>
> This is how I see things:
>   * In the open() function, the driver will do the coherent allocation
> for its transfer_buffers, fill those into URBs and add all the URBs in
> an anchor.
>   * During runtime, the driver will keep recycling the same URBs (no
> need to kill URB nor to usb_free_coherent() the transfer_buffer).
Yes.
>   * Finally, in the close() function, the driver has to kill the URBs
> and usb_free_coherent() the transfer_buffers. As far as I understand,
> no helper functions allow us to do all that, thus requiring the driver
> to iterate through the anchor to manually usb_free_coherent() the
> transfer buffer.
Yes. But you cannot nicely solve that with a flag as you proposed. You
would need to use a helper function.
> So, the intent of this patch is to provide a method to both kill the
> URBs and usb_free_coherent() the transfer buffer at once. The
Well, you don't directly. Your patch frees the buffer together with the URB=
.
That has some uses, but you still would need to iterate over the URBs
Yes, there is a helper for that, but then you cover one and only one
use case, that is, you leave no way to free the buffers without
at the same time discrading the URBs.

You can do that, but it strikes me as unelegant.

=C2=A0=C2=A0=C2=A0 Regards
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver


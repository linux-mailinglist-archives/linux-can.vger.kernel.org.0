Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478E453FDC5
	for <lists+linux-can@lfdr.de>; Tue,  7 Jun 2022 13:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243084AbiFGLql (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 7 Jun 2022 07:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243076AbiFGLqj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Jun 2022 07:46:39 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581677A458
        for <linux-can@vger.kernel.org>; Tue,  7 Jun 2022 04:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1654602395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cZCctLHX7es/2NAh9ee/LaW+KrlU8At8hP8bFP/P0rk=;
        b=db7W8vG+F1At3L0zuzz/i+WFvXkzSLvPTG/NpiEzUANtVnIkESZ8Uea6vm0dypx5OFYrCm
        vO6Cmi4P79GPiKyzir2MXdIHHIHyMn2cXIiujjADgMgurGkGu0FXBjTD3WbR7CSix3nPQi
        XR4+9IYyaxjt3YYOONAF+BovlLvStYI=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2056.outbound.protection.outlook.com [104.47.12.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11-TllUU4VINSCynnZt-PMDFA-1; Tue, 07 Jun 2022 13:46:32 +0200
X-MC-Unique: TllUU4VINSCynnZt-PMDFA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3PD0pOx6Iq9uVT52ml8vAM9xpt21pWbJKFZTc8651mmxB+p/cpMyMo5zbr4xTJeiitCTJiMrKn3ip89z2/dixXDZplq3ZvaLbcknxIs9Dbn741EBicSlLcb/Obi4tKVXT+tBcsTVq1IHqpcSTDREkL6IacFGgYG+YAglTYHKg8gf2yzNx/vfHQ26NfEjmfVGlgR14PGRcJ2uduoMhYdpekOZzbUioGqdN23byqyo41OUeG37sLShFTvBfNjL5yVq0n92EA6Qvf+PGqRg0AZpYRBikIuUEqOj8eujcVASim6dKev38mHfSNSIuHGzKYlfd90ieHf6SxHiLo8VDJrGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEemor8OlJAUx4cthVSJ1ohCU9D29ivBK66Vccx7B94=;
 b=iwp7Pz9/Hg4auqtnzQtLji08oA2nbhA+o4RsNc7nldJH3DJzw0mOAJ5hOpLiI033abXckdaMxk8ynd9gVn1rdL1JpxZVoYSWZIWFR1FOMP5yPh2axKVWercYvyIdlP489WynP8P2uVSek+DGDFhg87c15FhYUKa5O789aPsRIQ2LILmctawUZDxnx2MWakc9itmXALUr/Hd5wueQ7r0p9EyMps8BZlVf9km/gg/ArHKVwNTy45lx6jHuTBX6vwkwj+7VTbTYpgZH3H4eI3qDcMy1AC1napx9VFn8sA8xWzVvj8B3ZRkF8d0HNTEUZo8vT56iLRIAF5WWjrMWRpLHpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEemor8OlJAUx4cthVSJ1ohCU9D29ivBK66Vccx7B94=;
 b=Xmm77UGXNF6dMepTeO589fO981WGTIbYY5vwe267oq2pIUi0P2eeCe/JnbGfjnclhtuAdYxBJoEb6eGdiIKsjOQaUiQVrpITC4sWH/MSsKzxPz098WkZkNa6CTJBilrkEaUB4CtPDQgJ2rPc9My2DWJANp8UoFk+GKpDKDcI0IQEzr6BPgT9cjEOe/FCaGgWTVWzD7OZFGlQlW2Qk6TKFozNbq3IY1n0gko3e0t/5eIXDa29S4U141Ei/ejbK2gC4xTfX2F57cDfZ5vej6wcHHh72fDrEhUUquyyQt473eIOqyPNebe+LrjiSHVHU4BqdU0klqpFCF1RATOkf2GPlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by AM6PR04MB5048.eurprd04.prod.outlook.com
 (2603:10a6:20b:e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 11:46:29 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::19e2:fafb:553f:d8c]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::19e2:fafb:553f:d8c%11]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 11:46:29 +0000
Message-ID: <409f73a8-8679-61ff-4da6-018833c7a96d@suse.com>
Date:   Tue, 7 Jun 2022 13:46:26 +0200
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
 <66b14321-667a-46a3-27db-cb8682bd5476@suse.com>
 <CAMZ6Rq+CtOQ7Gn62QQqDd=_0dvCNhh5g_oXB6LmHEd0MfRym1g@mail.gmail.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <CAMZ6Rq+CtOQ7Gn62QQqDd=_0dvCNhh5g_oXB6LmHEd0MfRym1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS9PR04CA0119.eurprd04.prod.outlook.com
 (2603:10a6:20b:531::15) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d421e6e2-7127-4bad-1606-08da487b5c14
X-MS-TrafficTypeDiagnostic: AM6PR04MB5048:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <AM6PR04MB504889A35F8B0A63FE626E13C7A59@AM6PR04MB5048.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: waPkZ/fQ+btcAP30xfrmUCyJ5H0vTmcnD7X+ySK0/hhlH5iRhUylPKcqaSSJLctYhzaLvuot/L4nOH7OpqA9lIdGxOJZQdb9SRdbBaH0Vq6TCKEv2y4QeBRQevo3paR1Ndpxyye55q1YbkGlKgnhxlIdzYdPc4m4zQtwaEemvA9edQpc7Fhf+fEJutefcxbnLzxL+yBIxwCYJ7Aselore/LA5FrMZY68DXMwKMs/yXEf8xqu6xb3riS+KNyjiSSVRsORjpYRCYAiToVqaV5gvea3mrFT/SS10EKX1iId+Q/2ydzi3k1rfyh9R7y9QSkMuC1r3Lhgo8J3ZS5bzWeQ621Is5ftvyq6LRoffSOnbg4A8uecJ37OcEKFd1wQMcdG3vJnYhOERGLudLKjCMGtBtLTGOhSM2jiybQ+B0dNetTQEXaAO4gLHk388ZDgEoL0kmm574gi3V3Msb44ts9oMYsDuAyumxVdo7OyBDjlw4j6vkUMBOc9JzRHeicXuARmThJD4Za2RoGlA0EI8+PGWehdyMKuam8ZbD/+OgrZivZLCqoOC92GxK+QDgLHDPMcAhUZUz+yjWVaNj0tDGeuvjR37dk6g953LVrM+QkIhzXIRdp4PrpG+ct7AuLBepVWyP5rqTN4Y0FbEtmUDmBWJhdRGGgq4TORYZXdAbI/6pOXngGXz4hYTrx/VBxrvNyfbz7QPTDrKwaN4reNU318YzLduEUEBC6YBPuqLLckaws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(86362001)(8676002)(4326008)(66476007)(66946007)(2616005)(66556008)(186003)(38100700002)(4744005)(2906002)(8936002)(31686004)(6666004)(316002)(36756003)(6486002)(508600001)(53546011)(6506007)(5660300002)(6512007)(54906003)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xnSvO+YguYalcK0+3XlR9YBpqzgLsxajIVjZ/NTlgdlMczr9EUvC/ljTpgkB?=
 =?us-ascii?Q?Yj2LLzGnAUHhPAbD2/0CepF3KfEQrk+6lewk6Z6mzxXj/eDkrOQfoUSqUjl3?=
 =?us-ascii?Q?YZHqhu0CU8825HN1SdA6B0C5SOZabxC3dJYhceXVE8qW2lNXMQFGlNTFrIEz?=
 =?us-ascii?Q?JgdESj++17HtA5urUTNKEIerjE6lF9w0fnq9jeQvYw8VdzDYsBx0TgnA+Ojm?=
 =?us-ascii?Q?fqAItNRk2KQ1v0ZEQh7gYJikpz53Ja5qpAPNCjeu6V3DDpEEC59MFN/V523V?=
 =?us-ascii?Q?7N9GtLoou+rMrmLBcOPtQJRPopl4gahYABUffdgQ4JW9LrMPAD8/2qUFSwJn?=
 =?us-ascii?Q?PUmng5K9eANxo7uBE83BMh03wTgREXagxHVpr7mqBpN6xDl2Ia6boaXrVD75?=
 =?us-ascii?Q?C6EswYKD7YOqlQeYzOY53SVMUcWPlXyzo8PKi4MxbZl2W1M2ITjUR6wK0qkb?=
 =?us-ascii?Q?qbXw+q1qiR6VTdpzjtk8GYPdCW78ZiNATCtVICwV9dvxQNGmCO78lLuHiaVy?=
 =?us-ascii?Q?HQjmG6iM6Sqf6XzZGfjqbcVIdaP7GGhARaUH9STPUVohN3ed2CoL+7J1Bam4?=
 =?us-ascii?Q?WfEUTJiZmHPc771lE55axW2oqjawk81ki1KMF/CGWRf42wgdZjGlU+QuQRId?=
 =?us-ascii?Q?CwfdvAXm0wWsfdiqnCS22A3/ApW85GEXbxd8doOhGVuIujS8eiJvqztupA/K?=
 =?us-ascii?Q?j0IysIIlf+1X2NGnUn4nYVAwGktcvWb7aM08NYyy5YsliO9FWivFJBTy3/jz?=
 =?us-ascii?Q?MFmEudrqByX6m8E7B91MhwW6f2WGUrlHa375VeYDNFrRizcIzzeJPKnsfo9d?=
 =?us-ascii?Q?LZMPEUcHw5MphL6by3Zk99aOe9IiRXIm1wPd1izjT0iZH3KITa8ojW8lhJGO?=
 =?us-ascii?Q?Ofxy0qpa3sHfUewnJSoZBShMX9i38Krf6oPA4IhHzppETVbk3yWZiMjDKeF0?=
 =?us-ascii?Q?u7wDxASG99kBu350K7VfQIprWN9ZH/cD3oCJmHh8NAXBnrusXu/eHRDAKHn7?=
 =?us-ascii?Q?v0+9epgVyIloKcU1XTIMNm8CQVCDsrSiCIlFU4WHB9auqV4mv3McuL2rs3LL?=
 =?us-ascii?Q?lw/goilLOPtvXN461u1JyQQZTmDv1y3az8geh3BEj45lO/GzEHexcdFhJAK1?=
 =?us-ascii?Q?U4F6o4K+qB2mfBqSFx8Xx10BJ8JiWTamVwwGNNxW9qQg6wOWi/kW9j986OgE?=
 =?us-ascii?Q?QsqlWDBWpo0GisgS/VfgNAD/VSMNnLh3KZgzKOSlr1f2Y22m96sHVwCgpU/U?=
 =?us-ascii?Q?lu5PmbhNibwJFX5XEzsYB+EVX90v7P93LTbELsYnyeSiNAfRJON0sF0NDCcT?=
 =?us-ascii?Q?3t1T3+VcwD+NvEFpUNeSaUPNN4rPptzuogQBCRjMJtnM46V55uV/Du4IPKvB?=
 =?us-ascii?Q?dhGd/gfIs40LZ9JZhzHxTJ9zqOaIVsql4fVYv9iBw+/kNlrpGVu2i7fl5XTb?=
 =?us-ascii?Q?gv1m/1aA7+K3S/Kual1TtB5QVgttZNwJuURHvpovAtnLe3XS1ma8pZ17IGhw?=
 =?us-ascii?Q?vKgS02dMef6DGB7NU2zQ8quLQK4qq2PdOA1yZd5fATBf8dS9AgiSAmkb1wvF?=
 =?us-ascii?Q?rAz89EFPiuOI8FKE5lbtpMOZoRwuf88l/aK3/CeKUUusGTwh5HU6ojJLCnEP?=
 =?us-ascii?Q?1UScV/XV6XhjpjuMC1LkmLSVeHAkBeecJv+CJhiayUuqePydd6awg5LkqOIb?=
 =?us-ascii?Q?FNbNO3WGdSfL2OCMFu7uj3nBLH38A8E7n1DuBXbxTGaNAcM/tXYK0i9ecxQy?=
 =?us-ascii?Q?YAmvuKxpHeqvEcXg8ai7x4dIZFMYVcSYEmzvzIgYoFzx/v3oIdG9ZOiA8jSj?=
X-MS-Exchange-AntiSpam-MessageData-1: VGY5asiG06A55w==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d421e6e2-7127-4bad-1606-08da487b5c14
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 11:46:29.1375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWHelb68s9haQdOVtsAW00Wwxj5OhXo4SbgDI1a/Fr35DNtPonyN80HVR7v2o6bj6dxf4dZCHloCHKjCzlkglg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5048
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


On 07.06.22 12:18, Vincent MAILHOL wrote:
> Here the proposed solution was to keep a pointer of all the
> transfer_buffer in a local array to be able to free them when closing.
> I really found that original patch to be unelegant which led me to
> propose this RFC.
It was.
> Comparatively, I still think my patch to be a more elegant solution,
> and the original author also seems to share my thoughts.
>
> If my patch is unelegant, then what would be the elegant/state of the
> art way to free all this DMA allocated memory?
> (pointing to any reference driver implementation should be enough for
> me to understand).

I have two options to offer.

1. Use the existing URB_NO_TRANSFER_D;MA_MAP to decide
how to free memory.

2. Provide an explicit API in usbcore among the anchor API

=C2=A0=C2=A0=C2=A0 Regards
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver



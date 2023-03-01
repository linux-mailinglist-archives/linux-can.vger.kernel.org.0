Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4336A779C
	for <lists+linux-can@lfdr.de>; Thu,  2 Mar 2023 00:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjCAXRl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 1 Mar 2023 18:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCAXRj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 1 Mar 2023 18:17:39 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2092.outbound.protection.outlook.com [40.107.21.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632104393B
        for <linux-can@vger.kernel.org>; Wed,  1 Mar 2023 15:17:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQM+C+XLdON8cbAbgvqt2Ssb31/muvFTICZMBBtomf8rs8GBqLfZbqzCHjFtKugXsuqZAMZjJISMu1LDcXw1tugVbaSW3oQWxvohFuhT9homM/EecsDyNItUXi0CEX5rpz63sPRxeWA0JFR4Jm54iY17jhF99azCzJ/HSycI1LRFlxOoV5iL1oaqtURiGmmXVSmzqaaaoxfsDomgqAR30QBXszR7BVgdx1Bh8J+9s3VOkTaX/6u7vFlCY759s0RVSoMc4oUww0hYhno3/YqGoLtG7PdTmJqhHcxvxLJw2VV9AsWLRT703V6mmYWVFfdPvgAeiIaPm4z7I7R9DoZKgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqlqiqv7VSFg/jIoQyXNrQ0n47p8Uurk/ruJQpjByCs=;
 b=YXMID84ooyRuyGa9REEiPdX54QafbJSf6D7h8F99+dxj/uDGsAdJJct9sE84If4ruG+IlUZpn/cT3tEV84OwE/6O9ff0xy4ijg2OTRLaDaHEUMQ/WbthqBq4hDNNSX4nsdzC/lVM6qh1DZWaOuciBfQfgP55xtcCrh0nn2GJ6DZaH2DRZF5C0AznjDm5/oD0geO5majuH7NUPFLY+K6ktP6qf4AsxHoGuckOdriUq9orqVsThKHWNx2sCXbsm/6HOdy212+6tiXzJPtQ+3sp0mBC6oHB7TKB7VqkXTXdW9IrlBoskzepaWRgzQdj76673zRCSmKHOTQ9Er0pmAjXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cvut.cz; dmarc=pass action=none header.from=cvut.cz; dkim=pass
 header.d=cvut.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cvut.cz; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqlqiqv7VSFg/jIoQyXNrQ0n47p8Uurk/ruJQpjByCs=;
 b=KfU1tpoq1KvnIEbHbxkpPP/taU+GLfCMVB+0saQZ6GM1+6lIsDXusQEaiaMLUib08UWOqe81RWw17j8dG+2PcEZfXefnKUoNwpddRx1oDqg74cGMl4HMWNRcVOnH7rInisScfZSfTYPtyGe6pOH+iTODjQBHVyUR4PQjesD+Sq+jtJ+sOlZUrda2WAT5Y9itMgRf4Xgp5oKNDKq34ZRRkRSVk52887upEInIZp/P5GvHgvwU0Cag8GT0kyk7qsaI2HZSMtvp9w+B9qOXk5IEeky3CQ0d0KvwKHAboLB/I4GwX1JGUXWqC8/tOxKus7AHW6Ecrj/Sel7Xo8+pk62StA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cvut.cz;
Received: from AM7PR06MB6550.eurprd06.prod.outlook.com (2603:10a6:20b:11a::12)
 by DB7PR06MB4203.eurprd06.prod.outlook.com (2603:10a6:5:2e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 23:17:30 +0000
Received: from AM7PR06MB6550.eurprd06.prod.outlook.com
 ([fe80::d096:71e4:dcf6:ad6d]) by AM7PR06MB6550.eurprd06.prod.outlook.com
 ([fe80::d096:71e4:dcf6:ad6d%8]) with mapi id 15.20.6156.018; Wed, 1 Mar 2023
 23:17:29 +0000
From:   Michal Sojka <michal.sojka@cvut.cz>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Jakub Jira <jirajak2@fel.cvut.cz>
Cc:     linux-can <linux-can@vger.kernel.org>
Subject: Re: please re-send [RFC PATCH] can: isotp: fix poll() to not report
 false positive EPOLLOUT events
In-Reply-To: <3020cefb-0dc5-bed6-a31c-39bbc7fec3f4@hartkopp.net>
References: <b53a04a2-ba1f-3858-84c1-d3eb3301ae15@hartkopp.net>
 <878rghtt0p.fsf@steelpick.2x.cz>
 <08d8e225-0e7a-a75f-f8fa-e4a8ce99d4a4@hartkopp.net>
 <3020cefb-0dc5-bed6-a31c-39bbc7fec3f4@hartkopp.net>
Date:   Thu, 02 Mar 2023 00:17:26 +0100
Message-ID: <878rggxdrt.fsf@steelpick.2x.cz>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0063.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::40) To AM7PR06MB6550.eurprd06.prod.outlook.com
 (2603:10a6:20b:11a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR06MB6550:EE_|DB7PR06MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: dc57c2d2-56bc-469e-df12-08db1aab202b
X-LD-Processed: f345c406-5268-43b0-b19f-5862fa6833f8,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ZuDQGhng321nVq86tqkB2iKy9VRdmhR5bP22k7Sepb2GldCgAvCqsBk3C3iZeHcu4tKO5gY84tAK1fENZjXN1uJ+4TmbsS+DTXS7j9ZAAJn3h1dt0am4r8iD0N6A7r0R9EbpPyftuS+RYm4JsGdIgbpoql54N8PuOlh5T//YJC0RpVLNaB7/QBS3Tt5AeoR8MrMLrXvUIK3YKKiyipZHx2Ba85q3qWZ5plz8uqMbl70ISMN3UF9b5vapvlQgm8dj+X07DWJcrQkdo5UV5TRcmuNTg/+xLbmyoxpQskUf9oydkCXHaQPt696Hv5UR0bxcBjKNK1ZiXdHkbRaeg/lYVSZH8pXuZInpxVSPq2UzVNbnw0cM1o0HxvtdN62l1jR9yCO0UCRnNilKWZDuvPRKPPAIoAf405Kx/N3ymfSESjPzl63cP/+mZZQPEaU5FihLHfhHUV20mADzQ01KSPxj7pqWyEt5xiW5y+wDX0Qb+TWmuIVsXbadB1LEPHL+9aMvcEq18Or29zuott5c/wFEVIQNEOOPTpsvhfTZlZ+MdIi8yboS8D1i8VTRvE4eqku6ph2ltBFq8NtdQ2VVuk0RG8W5VYg1iBWKReZEzyYOGak0kXHRcEZ1NGEqSqC+BsJrgSmRboVDOyq3WuGYM7sXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR06MB6550.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(39850400004)(346002)(396003)(451199018)(6486002)(110136005)(316002)(786003)(4326008)(41320700001)(2906002)(83380400001)(8936002)(41300700001)(5660300002)(44832011)(8676002)(478600001)(9686003)(186003)(6666004)(6506007)(6512007)(66946007)(26005)(86362001)(66476007)(66556008)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LUFxWDd4vCzoIDyplSB71auyOlv30Tl9lGZpcB6wSjeZbje0C4X7PLuMdsri?=
 =?us-ascii?Q?wNLbuZu3LdYbQ3Rd2bEgz/dNvid6Tckyz0xYhg7YmCiaZ3XgndMttBdrVkCS?=
 =?us-ascii?Q?gRntlP3JI8S75ZXUG2rHn02OFxQG65TpqgJ0T1QBY0uXndZN634saOlvrczg?=
 =?us-ascii?Q?YT+28gtDv6zPxX+nelPQvgGsoRPlxs6m7NFli24P3QBI/gRHw0lkKv6wAHxj?=
 =?us-ascii?Q?hU/eT5kMoOHc5ISNXPUWAiax6/RCi4r+nZXh0qSsz2gJ6f7NRv8lfYaRSaB/?=
 =?us-ascii?Q?Wa2QtLt6FZmOSfUe69BQpSVpsWJZEGsjzN/L3UEj1UoAYlnRYIugSfswe286?=
 =?us-ascii?Q?0GdXljyBt6nx+grKdiWm4IXcYHXj7kctZo6+Oa/v9wixREsKOLYyCucUDUnb?=
 =?us-ascii?Q?MlubpJvFpTYwaWNwxA+mVu1wQRq8fitzFiNcTNGq/PtobrFlfoIw2pFgYk+E?=
 =?us-ascii?Q?ZNVypxreAEBXHbEeiLsjf3iSbE8Dpr0SVugK3YfYLJTyKj4+9NC3gNapkqab?=
 =?us-ascii?Q?IsRpKceKAhq5e0Yc3Y+PV52sfpCxwQo2Q+hpLV1zfmoZ2JzVyEg+TrIJUaVh?=
 =?us-ascii?Q?GKxBmhtVNV0bTG148L9pSgmoqSVs/heMZ8OrON6sRe1Z2mZVFMv50ohH56V3?=
 =?us-ascii?Q?d7PQsB/DW9OOrfN5yYyTwge9wT6DlvX2e7gw5uItHoZ4O/NjbBeUOuSrDwvR?=
 =?us-ascii?Q?j/CotwB8u3PGjFlRsXUL0/ri3fYed8OtnEydmpw5W0ZNho9qf2U98RzWB4VQ?=
 =?us-ascii?Q?i8H3xTt6/gwu5YYPDcEvHfld5WJ2kWC39RbqCBgon4tWQq87zfjCrSExnCvV?=
 =?us-ascii?Q?vIzZjS+eMCvn1k7frY41mtzkJHX/+ycFhTNXMIcPyVBBi0WLVQYRkB2liz9T?=
 =?us-ascii?Q?EGHOwq/GFoY+1wAbfZ+lD3Eqp0WmS8wpjy4zT9wfk2lXxhUfBMzpMiAtuyjm?=
 =?us-ascii?Q?ZnVpEcduG66PTlOuK7EZCYZHj9/NvZT8cvs5OX1Jil6EbV/UD4nQwmUk8Ylb?=
 =?us-ascii?Q?1CZ/4V3vKjMsRVWLE+Fz6wbG4nXe4HKRhanloutGN8AjlSTrH9yvqgHvH1Q2?=
 =?us-ascii?Q?3woLOTbCjAk7HXwn3GmVxDYAkUC6tT2R76IHXJYS7ZtqQulqBujEHwp59wOj?=
 =?us-ascii?Q?rnOlYIhCAhPcVuZ7yXy4+sVY36+fLZ9EruCW7Q7Fiu95ahckXVB25ACVCul4?=
 =?us-ascii?Q?jbSWn/2XiL8hWBRAvx0MV3QLNgc6l9ffC56TTdTsqKwe6vks3Xwp4hViHuCY?=
 =?us-ascii?Q?ItWBJhQA9Vxkl+WTKw/l3yvwapZns+Xx5lBDsxMHAnzxqVqRLQZ2rYbKZjmg?=
 =?us-ascii?Q?IZFSOr9Qg0vFw3fHJQHKNIE8GDC3iz79Q9npaBzENMCAvsPDTnemrXXOBosi?=
 =?us-ascii?Q?wndOc1cNZE+BH98K2HhvMFzLSJ4k/mW1PEq+Tcw1fhq26yItAP5g87Dd6Y0O?=
 =?us-ascii?Q?Q2rpcMD5EIXRO+8OPsAYffmEb/tSFXPyZd9j+7s9qG6EhC8sAUebpmMCR6oZ?=
 =?us-ascii?Q?FG1SelZLCwSqZ9JNJv71ZnE2pOvDUN3gJTBro0+BTqqHHMdr2HkI4Wg/sCqB?=
 =?us-ascii?Q?iKUerIJ+A+zD+AabQmRyborDncEq1zJcwylCZJcc?=
X-OriginatorOrg: cvut.cz
X-MS-Exchange-CrossTenant-Network-Message-Id: dc57c2d2-56bc-469e-df12-08db1aab202b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR06MB6550.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 23:17:29.5473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f345c406-5268-43b0-b19f-5862fa6833f8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bavo2r1K15JplN+nDIY71SLsX7+yFCZaSR0c9jyJLOsO5K1QkgVLcfFvtT79HbO5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB4203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Mar 01 2023, Oliver Hartkopp wrote:
> I added the sockopt CAN_ISOTP_WAIT_TX_DONE in isotp-poll-test.c which 
> fixes the problem:

I saw CAN_ISOTP_WAIT_TX_DONE but didn't want to use it, because the
whole point of (e)poll/select is to wait only in poll() and have write()
execute without any blocking. In a sense, CAN_ISOTP_WAIT_TX_DONE is
incompatible with O_NONBLOCK sockets.

> The sockopt uses a wait queue and returns from the write() syscall when 
> tx.state becomes ISOTP_IDLE.

That should be the point of poll() too: Waiting until the socket is
ready for the next write(). As I understand it, the poll()
implementation is "connected" to all relevant wait queues and whenever a
wait queue is woken up, protocol's poll method is called. It checks if
the wake really made the socket writable (or readable) and if so, the
poll() syscall returns.

When thinking about that, I guess I know where is the problem.
Currently, we call datagram_poll(), which checks only sock->wq.wait
queue and not the isotp wait queue so->wait.

Tomorrow, I'll try to look at how to wait also for so->wait.

> Using the isotp socket without CAN_ISOTP_WAIT_TX_DONE turned out to be 
> not such good idea. But this results from the original API which had 
> some kind of "fire-and-forget" mode.
>
> Today the tx.state is set back to ISOTP_IDLE in isotp_rcv_echo() - and 
> with this short 9 byte PDU the interaction with the receiving entity is 
> really fast on vcan's. Maybe faster than the the write syscall
> returns.

If it is faster, then we wouldn't see write() returning EAGAIN in our
poll() tests (without CAN_ISOTP_WAIT_TX_DONE).

Best regards,
-Michal

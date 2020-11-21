Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F792BC215
	for <lists+linux-can@lfdr.de>; Sat, 21 Nov 2020 21:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgKUUnH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 21 Nov 2020 15:43:07 -0500
Received: from mail-eopbgr70121.outbound.protection.outlook.com ([40.107.7.121]:59214
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728402AbgKUUnH (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 21 Nov 2020 15:43:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6KabwzvzH7Bq/eKuONXd86uWMpEICYd2vXt0Ss64/HbmLAlhEZKITCqWUbA7ubZdeCkP0FH9TW97eMjK23rOpaOJdqf5barHzhKbiDeUaTyfrkYKJL+Hptk5AbS8aDq8+ThbQzPx2w5iOQRVsFuM+xeWyEtL2hWrJUOW4rfmtpW+0qVfxVLcoC1W5nkR3moyI5FFyWQwEQqBS+X0GG+2bKaFBLAZlAjYo7G9ZSea1oDwjSJhyGY8SMTJHAnbnOOCVqcKc/ldsF2IdT+jB+oIXYqbdL2IhMnVTmzaNXxw0NoT2+BHh5aVLqudSDzqA5b2hzj6aAOBcg0MiUvFPJhTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQ6AiitswaNKFrVRHud03uB3n4XUU0+f/+c48Up90z4=;
 b=Q0aRlvJQOooiaAGkSe2R9taKDMewvjsU6F3G4QupWujUKppAh2NklyacyGrtPsDbwhFKkmoC0UeRV4iYDPr3MNzUVAfkusOartozwr9f0L5aXFt8zaYDjPpfseflKTOZp9TgcCXpqD92R5//veUFjC7UMXuXQks056RThhJg3C5Or3//XbK22jzHMGXwWAk92SqousVtZ49MBRwBhxe58QMfKGT+2xvFZUYZ3U5BwGGQMdgz6pn44Ge61Q/K5TDU1EaNrX+H91gluXfQLe+qhjXpuo43UTw6XYyeHBdLTTYzyDO3Hgcf166qpf00y3NU+ilab9ovRGGyDYGUdiZt/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQ6AiitswaNKFrVRHud03uB3n4XUU0+f/+c48Up90z4=;
 b=wKsetEL9t7JBWVGYg0xxFKde084Q6l8n+j25VzyryRbb/q1rbjOtP23XOheWPhmaDGeXOXtKsZuq6vUedzrYqKtgxmr/VQWGNMR3dBJlj4SyHbfwBpW5frkMHoJFKp33sN278TmtCcMHNJHVb1pdnFUC9EOnhWjkWfrcm2wn/yo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=victronenergy.com;
Received: from DBAPR07MB6967.eurprd07.prod.outlook.com (2603:10a6:10:192::11)
 by DB9PR07MB7210.eurprd07.prod.outlook.com (2603:10a6:10:214::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.11; Sat, 21 Nov
 2020 20:43:02 +0000
Received: from DBAPR07MB6967.eurprd07.prod.outlook.com
 ([fe80::ad22:24cb:3fd:617c]) by DBAPR07MB6967.eurprd07.prod.outlook.com
 ([fe80::ad22:24cb:3fd:617c%3]) with mapi id 15.20.3611.014; Sat, 21 Nov 2020
 20:43:02 +0000
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
From:   Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: vcan rate limit
Message-ID: <46d8e940-0234-175f-2038-cc41f852358f@victronenergy.com>
Date:   Sat, 21 Nov 2020 21:43:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2001:1c01:3bc5:4e00:e791:efe6:bf00:7133]
X-ClientProxiedBy: AM4PR0302CA0031.eurprd03.prod.outlook.com
 (2603:10a6:205:2::44) To DBAPR07MB6967.eurprd07.prod.outlook.com
 (2603:10a6:10:192::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:1c01:3bc5:4e00:e791:efe6:bf00:7133] (2001:1c01:3bc5:4e00:e791:efe6:bf00:7133) by AM4PR0302CA0031.eurprd03.prod.outlook.com (2603:10a6:205:2::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21 via Frontend Transport; Sat, 21 Nov 2020 20:43:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6518743-9865-4c3a-7844-08d88e5e0a2f
X-MS-TrafficTypeDiagnostic: DB9PR07MB7210:
X-Microsoft-Antispam-PRVS: <DB9PR07MB7210F2E28867343C505809B5C0FE0@DB9PR07MB7210.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kHTdqrelvg5fSQxqnLDQa2n6z/Fdvz5KpcV3WgouqpeFihNTymxsddFySbtDI9K8qLtHd109jYOnzrB51fs9TLjxSI5Uhvzmu9OiEtQmkCG0Xk4ThGbImTdUSMwb+HwG9IhgCDwp4SIz9GUGTcSwV5kTZR5JYNl4xt180HFbEFZN1GqmVNbZH9rAJTOGv5QeKDqnYyvpr9uaAal/OZaQranqdJgOe6sIklxzScag3ynqRAytyrrMN7dEOX2BCgLB3r9LHc/Vc1tQdKz/832Z6YUlY2XRQYl1HS2DMZkCIvpvpADJ2C21owx3Xtq+9ONrbDDJO4P83p4e1zr7IDtE6u/BkX4xou2htuD9zOCBv588io0Z7dp+gUrRdbFV5aRXaccLpm94Q9AYLbHSZ/0a/OL7PFfGpEyyc5Uw05ioYS8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR07MB6967.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39830400003)(136003)(376002)(346002)(6486002)(7116003)(31686004)(83380400001)(2906002)(478600001)(16526019)(186003)(316002)(2616005)(8936002)(31696002)(3480700007)(5660300002)(8676002)(6916009)(52116002)(66556008)(66476007)(66946007)(86362001)(36756003)(133083001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: hn5d0+TYk1UFwSzs7YlXmFtRJnKq7SAZfGY3Y7hrXvwPPqozAr8Ple34Qpf94UM4yMyktwKAhf5gHi1WDSDGLzBTu8PVKHx9zwgzSxGnwZ2XO2nK5aGdLsbqIhfBprKUxSnJWsW87AIY93L5+Khzrj/8pSeNzdnj0zb6Mj1Fmv4XcbRXn9/EzOGqz0z7L6pX/9KQm9V2L7rKW2/zFL48RfusWA2QI/v9FndrDPtHjvLoTseqwAYHWHvMPEBDKjMZW1lkDth2vQzxKKZLq/J9ZYuv5itbI02Frqgzb+WGCkTk01S4eMNBhn7BHaWTFrK4CevNxAc3ge+B37ovsRqJ07JpY+Ife9CGwOq9hXQlfR4zdKWRN95vjH2duKkDtwOr2pqwDnn94/BcVYjwTov7ljJPCCTCbgw0oijo6RbPFUDNyZmmaTBS6iW/3DNe7F7HG6Ta5I4VButI0eWg6TGEn5Vg9678WO7GbfhfLoEhExqB+8NKrWQ+QDYlVFviWNSmdTwYpMmeK8V0Fx0fllrFVbncHwfrb9uUXaoABMoc0meHsjM2FtCUT5z5rfw0gsXJJ3Bdr2R7hJbYMHfoXTuFoY6R878fz2jD9cw2zAqsMsNwK3Op5tGL1dxpvGJvm5QUj4R8Box3FxleFLJnyWF4hbPcffDrIUERaQjHnK9FECXQD0ZH1e9RZm0SMWOzr8kB+4B6bqKkeX6nHvQHb55fuA==
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6518743-9865-4c3a-7844-08d88e5e0a2f
X-MS-Exchange-CrossTenant-AuthSource: DBAPR07MB6967.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2020 20:43:02.3232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8aZ4FNUKw3bz9xny0k4yuW+ZWNt7YxqkqmJJ6Ofh53t8d7cT+KxIU0dwau80b2WatEloquJMhYWVWcsmLmH9svxmT9X6kkaS/+JwkH6wYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7210
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

The virtual can (vcan driver) directly queues the tx messages on
the rx path. As a consequence a sending program, canseq e.g. is only
cpu limited and as a consequence the network stack can start dropping
messages.

For a realistic applications, it takes a bit more time to realize the
network stack is actually dropping message, since the cpu doesn't
necessarily go to 100%, it can just burst just enough to cause
some messages to be dropped, causing unexpected behavior.

The vcan driver behavior can be altered with e.g.:

sudo tc qdisc add dev vcan0 root tbf rate 1mbit burst 24b limit 10000

But I am in doubt many people are aware of that or occasionally, like me,
have to find out the hard way they forgot to change it.

So I was wondering if one of the following is acceptable / possible:
   - hint / assign the mentioned qdisc by default instead of none (no idea
     if that can be done from within a driver though)
   - take a transmission delay into account in the vcan driver itself.

Looking forward to your opinions / ideas.

With kind regards,

Jeroen Hofstee



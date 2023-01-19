Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22D767335E
	for <lists+linux-can@lfdr.de>; Thu, 19 Jan 2023 09:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjASILi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Jan 2023 03:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjASILf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2023 03:11:35 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D89E3BB
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 00:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674115894; x=1705651894;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=9nMtxFvhjKofCN6/G/43uVZwHr2YfE0yU5HOwJRmi74=;
  b=Dyk/EkXTDT5rBHZER9CHk8RF7sSQIpOuKMDD/EUEqdVwHh63BazmwnWN
   eXusMps73lZCI1ltxRGh0zS136XBoksBIJLvLZSwyy9VvAcburDRk+1rT
   Jd21HhyRkNi6VoeeFIs5QK53UV0+CLFeixUXOGMFDRzCal4JpkigcSmLJ
   ZDLjtaI+HRrmzWchRN1JpvzcsS3Y8xA3QMrTJbCMcVJ3OATmtU5D8uqQJ
   C427/ul+/+hNa07pQW+Cr6V77rrd3DKrtzRmm8ezTzjvJ/ceMSv0NfEgh
   7HjwZoEBhQYWdtYFsazPmHb1WlXsIyUBpAc+CTBKH93MXWPhxmalw3iVX
   A==;
X-IronPort-AV: E=Sophos;i="5.97,228,1669100400"; 
   d="scan'208";a="196486087"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jan 2023 01:11:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 01:11:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 19 Jan 2023 01:11:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtmM88sBu+sMDSHv9f5npU1zfRj0YNkzgV/7TLbmtvfmRZN30hmxthwVgt/ifMLboh2McYwdIT758ChZaE/EiVV6RGXgLHXBmZlunTvIMKhLIk9Utyut7wHP4u8ZciQ26msRMWx4qBMP7v6LMw+u9OgY6cWZZpvpu6uAVIY0jbxrFR98CQaOBDsLDdhYPX5Yzh6qzw7HpPuPsiuUK3h2FUgtvXGv7S1HNKr5AzaFbKLyCGrM7EGDDXUIqzh3PduSDb3L3X3BMT4LLN/Gqq+2rJjQ4qEB/AGztFfcGehwtk5JM3538btlf7MszvTg5beBNYx/lpNHtyhEG+iQ6eTZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5y3nB76neCa7ZMjKrIwWOagUgDV3IgQIufDmagsqjkI=;
 b=A8XFbX6M7j8AS8g1361Bg4NYF5hOhgFu+QqdYKHJMTl+jDUpdMPxi5+8G5l2NXE2jq2zeNXZ12Q4GAxgYCguoSDj/Pbvz9g0b9k8dhPDxzNvklgbeY4xLpDbxS0CIP1h5Lw+Qxzi/D/bUIzLbvX2ROIbkCACxhUDelLA6DKxlYN17e99jeMmoLM/xU2JhRr4eqbf0udeF6K73t+Znz4AdVT+YUvYVtzBTPW4pS4IIozgjb0zE+CAOiE3XmiT0ydmoX8wVlTufR1vlqD6BcQ1Gu7ZnFd3q+BT0f9iWqS1M0VZl69TEmH9buvCFOhWWkB3mHz/dFK8YEuYMzM3EJpCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5y3nB76neCa7ZMjKrIwWOagUgDV3IgQIufDmagsqjkI=;
 b=iV3aDTENibQ9f0umBaFlPbtU1IxW+qOgDRrqt0pYM+DgbwV6o1KDovCPF4egI0uxaWGjqZ2hbco3zpFxqpC3ErM9/MCQpCOeN+pMhKk0C/aML6xQskJIajElVG+YGfna63mAxNMZmsoD16RBTIN/RtGyIgt9GILyx5+COtrBtnE=
Received: from BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19)
 by PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 19 Jan
 2023 08:11:29 +0000
Received: from BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::cb80:ece0:6de6:f096]) by BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::cb80:ece0:6de6:f096%5]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 08:11:29 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <Stefan.Althoefer@janztec.com>, <linux-can@vger.kernel.org>
Subject: RE: mcp251xfd: rx frame truncation (1/2)
Thread-Topic: mcp251xfd: rx frame truncation (1/2)
Thread-Index: AQHZKz4szMq49nyLkUucW5HyhGITIq6kOILggAAd4YCAAPuhYA==
Date:   Thu, 19 Jan 2023 08:11:29 +0000
Message-ID: <BL3PR11MB64842584529FAEF279F7B137FBC49@BL3PR11MB6484.namprd11.prod.outlook.com>
References: <FR0P281MB1966C774C1ED0752CCD6B80497C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966F32AD422DDD867F8C53A97C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB6484911640CCC738ED799E6FFBC79@BL3PR11MB6484.namprd11.prod.outlook.com>
 <FR0P281MB19663A60B0F7CE7F684A7A6297C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR0P281MB19663A60B0F7CE7F684A7A6297C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6484:EE_|PH0PR11MB7424:EE_
x-ms-office365-filtering-correlation-id: 4be00171-17dc-4e6a-7784-08daf9f4c4fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KBO+8QurIPQXYB2NNbgb5z9w94AGjpnPCuGCzH1hMxPe/c8lyXmxWP70FX/52wgADxuvOSNipoRnTPd/iToGjmuxcilkbULCJAti/hnojJbwlZ5ySLcA72JxTWLUq2uYrWPlr8HSajkVUTQdk/RpaTVnn1bYEeehqA6QdVZ3C/w8RRBAih6dXFiD4qVzXSRjM4tPAYL3A1b6jHkePOa8yCqmAwjxodHNbENK1PSadvBqcV+Q8EBuQ+y6TXAASb2U/Dwl2KoLfCtRKpQJnFAWtNFAWSmkDZ1gxDH7EiV4B73Y5TOURR8PQs1wUB+sXYzg5tDlzbYUzVxa/5XD0p3/JwvxRa0l1PazwWS/K6w/QOsUkPe/5l97zK9ew/AMfOQ9a4fbIFKaQg65XE14JbDLCGvwWH/DREJnDk4xovSBn6MylHOxVSp+oPeApiPB0hinw8wwAmX6/f961GzS2VexVhxY/O5WYYX6BQPzFzSREVM8QgrESpaTj8zF6JJ+26K7sFpqGKVeQNx/OQkEIu5PxRvn4jk7O7efhIuOCGvChqYY1BAsQ3L6bNmAYC/uOL92zcOnXHhJn23fGiv7s7ooynQiR9APgf49P6tLoq84qljBPhJJcbgtUzG6sxMNrwmFX9kXEpwezP1wN7I7Z0ab3LDyE2FNejIuIwJzzpZcLGnZthKcL/TguPRiAPRA4AgQizLEWHCXUZaln28RU+R+/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199015)(5660300002)(83380400001)(8936002)(41300700001)(52536014)(8676002)(66446008)(66556008)(66946007)(122000001)(86362001)(33656002)(2906002)(64756008)(38070700005)(55016003)(76116006)(7696005)(66476007)(71200400001)(6506007)(38100700002)(26005)(9686003)(186003)(478600001)(110136005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e2Sk9+pGHLqRffFbBTvL8VaiJCs0s7r4KyhI2cfAU89FMm0sBVoG5PI0IN?=
 =?iso-8859-1?Q?D+siZnjp09uRnC+c4hgvrPRT+W9+VA9bd6j7f+oXBYyApRJJv+gMbhTk40?=
 =?iso-8859-1?Q?58YAQBPdfylQhAWr7VxYl+2/D5nMnl5dd4wlhI2ga0qdNXMoLkp0IqhzZH?=
 =?iso-8859-1?Q?PstaF6zbT1YsanpOBqaWyjK/nar0Nj7zLsB1jB103B9x+jjBCn7UyjA6hf?=
 =?iso-8859-1?Q?qc3TQ8AdatZc2tPdZPYX+PJUrSPiRoVt8hUdlCEnYB841Q+hUqMYfDL45z?=
 =?iso-8859-1?Q?LaWAP/4r8H+s91vGDNRA/uBBvIXzCckd/vXYymi3oa8xHyYk6vENYqE/8W?=
 =?iso-8859-1?Q?ph5LyVrlj3kGLh/mJw2ggYUgovKzFLFLmQ731Hxyw3SDOCNbNWRbVSd617?=
 =?iso-8859-1?Q?GOzkHY3uRb80tSXgOjYL2L+mQ2tw5FwDJO/RgFVttKC2AHMGZWjybhrAoR?=
 =?iso-8859-1?Q?VJM2WjgBnZ2zFekSpXXsd41Y12CcVkox+I06TsSyZyiGMyKEtMKqF2x6nI?=
 =?iso-8859-1?Q?HNdQfwMpZwwJIsOngbGOy7X9zC5rHJBpjdYkQTpN6M1035kk1yRYFd5fB0?=
 =?iso-8859-1?Q?KB1U3p5wLxD72rpZD31e6jqf1QSfF/mDhqBADK5mo+g3XyakVWdYKb1P6y?=
 =?iso-8859-1?Q?lPFIOmNcwSOs/vFC7v/JJhIxbBo+Xh7WJqyGFu6ZxgTDGToJ9h2oEcsnfz?=
 =?iso-8859-1?Q?C5tIyjGI/F4xIF53uhvRP6MvHpv0vJdVd2BtJ5An4N+2Ep7ETXBP6/sdrF?=
 =?iso-8859-1?Q?9+fhcHFTjqXOItpQL1pOk3OTf0oe0IhbAk6Ai0njPopyvCIkgikBhMPsvy?=
 =?iso-8859-1?Q?OsiRavo3oNvwm6I7cYmTyPvvEk57UfN+Qyh643NUlNDCOJ+9k+nc9uk70p?=
 =?iso-8859-1?Q?nDA65eTwtUP3MV0AHBz0o5FneYAfrHHZua5i+rDxnKYjLUYmOyr84Z/AQY?=
 =?iso-8859-1?Q?Lb4O3kUnhJjF/rKcdEfxp/5r1s8DHcVeVFeqpfRegtc0lKPO/mWUYlYuZ/?=
 =?iso-8859-1?Q?K4fhV+gDJMCF6u59t+7jX/Gqnm1vK0S/BCxLR9OGQkaASIHU/spiJk6+0X?=
 =?iso-8859-1?Q?CIazDlu2o7MBu8o7Ow/RPNKpycqPnzFHdRHsUNzqyAdM6soKLzORfoKCMC?=
 =?iso-8859-1?Q?d98ZZD5zz12cwq1g1bAD3EuZC8LbgYbeoK5ni+CpxtMsJn2pJw+6laAX2t?=
 =?iso-8859-1?Q?Zz/JPpqYMlA0xRdqoCbTU3aSnXf0Vtc9w9+TKne5zmLi17MdZXxRTT9K9F?=
 =?iso-8859-1?Q?/xvVVgjNrSVdf9XerhHagMWWO3qgxjWlKTHqyDcdczTv8wkQWGp9bcUfCW?=
 =?iso-8859-1?Q?TZsfiBs0cbq/GXMFkktciV/1juMt3vhsveNeL3xzCzDtyc6Ag/mc4Cq5U7?=
 =?iso-8859-1?Q?jSur2ED8ZSsynZpauO2yez5gCKC+woUgHq7tDUntU610QZ4n1sfsLGdOxH?=
 =?iso-8859-1?Q?0a2iHpG0hDbXd1R1KVfmHRpF56WZxVc9/HBaGT1A+T5To3vMfkG/szrkb5?=
 =?iso-8859-1?Q?ddLioVxF0wIuSh8tVspud1rWuHYWeIjg0yPYO02iI9x4nNF7eLG+lnZPna?=
 =?iso-8859-1?Q?2g/rS9cl4OUCVYkCXQE+xmEQbWpP2pjlHhyOpW/H3SOIIooeiHJ0/mLG6g?=
 =?iso-8859-1?Q?9YOeEzmycYCee95LzyJCzASAhcimgSLvYR?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be00171-17dc-4e6a-7784-08daf9f4c4fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 08:11:29.8119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NCVbqI3pYmkST74VYiJ7ZEppWpgPvUEhqP2mvMMGbXF4iH061KZCZVHjvlW91qsHX4tPQ25EE9u/p9lr+CwDiyR06nYvFEQKkZJNv8YMO6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7424
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

=20
> spi6 (can1): 10 MHz
> spi0 (can0): 16,67 MHz (admitted, this was not intended)

The 16,67 are expected on the pi4. There's an erratum on the chip which mak=
es it only safe to use SPI speeds of ( sysclock/2)*0.85, so 17 MHz with a 4=
0 MHz clock and the 16.67 is as close as the pi can get. That shouldn't be =
a problem though. I'm more surprised by the 10 MHz though. Is that somethin=
g deliberately limited in your DT or where does that come from?
=20
> Funny: the truncated message was received on can1 - with lower speed. And
AFAIK spi6 is different compared to spi0 in more than just the speed. I had=
 my setup(spi0 and spi1)  running for a total of 16hours but didn't get any=
thing. Will switch to spi6 instead of spi1 as well now.=20

Where do the 10 MHz in your case come from? I think the spi6 can also reach=
 the 16.67 MHz and with the throughput you're generating with the testscrip=
t that should be better.
For the record, this is how you call the test as well, right? ./sctest -b -=
l 990 -v cmperr,logmsg -F refilldata,lessdots,stoponerror,randomize -d 64 -=
n 10 -t 3 can0 can1

> I have never seen other CRC errors than for address 0x0000 and 0x0010.
CRC errors are very rare in a non-noisy environment. The two above are exce=
ptions due to an erratum (0x10) and timing(0x0).

Thomas

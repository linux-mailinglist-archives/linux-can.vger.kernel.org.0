Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90094EB871
	for <lists+linux-can@lfdr.de>; Wed, 30 Mar 2022 04:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239261AbiC3CsN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 29 Mar 2022 22:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238511AbiC3CsK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 29 Mar 2022 22:48:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922EB170D93
        for <linux-can@vger.kernel.org>; Tue, 29 Mar 2022 19:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648608386; x=1680144386;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=DnOVa4b718jx03YGZYmGlNdQjbG9DB+3+VpCXSsJXWY=;
  b=lXcaFGBhMw+ssGeju9g05uM0VHyIHZ9/Lh0BKoagm8baOscSnCeRro5k
   tmHxHTIixTN7p7BOwvjRTyVVL3VAjxl0ah7i3wULmckLwHoREDMk6yQL9
   UqZRlf5PhF7jAbyNG1gkriOobOc8cIZP5Mqw7fFRgriwa29fjA/RUSYdu
   NJtPF8RnotqaugpJDaDpNop+tiM4QjSQD8Qk+8OedT8XcLIdDRsYgzRLH
   pPpLr3+27yYovaIRX/9zAmX6Hz9GZO53t7yF/HRsTzEcuQhSayW6LYw13
   PEFTd5WipSIhI2HJW+5QKQ+WpOfar7x1/9cw7RuP6PPnoNDAYBJhiT5U/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="241586984"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="241586984"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 19:46:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="649698354"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 29 Mar 2022 19:46:25 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 29 Mar 2022 19:46:24 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 29 Mar 2022 19:46:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 29 Mar 2022 19:46:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 29 Mar 2022 19:46:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=barcIiXCNVaL1tPEoDaeuBe4SzysDeC1YnhOmeFPGyJFJoMrCP34Xrhx3O3Ot1y/vLzmHxLwUj0cKhbdAb6sGn6QlHzLXOM2rVVgyLTc+5dZuOqwgmc0Nwvtb+qh1TKlWiQnjV8DpcpyDslzPv3t4mVIMB1/QnUXSVWTaMm7TafC/lPycj7uVQQB1E0DCf9h38ow7rGBNZ6gNl6pVj0VhAnGvMDRUWxSfs4Ax6AB1SLzkNaM1HzzOzdLCIJ03vzAZ7mE0nOiwqnO7V9TMXLWKBz7ujAhdgFKRUeNatiGj1FUHp29JPcttp6PHUxEx7J5B6WSJ1wmxlf5oOn0v2nHbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnOVa4b718jx03YGZYmGlNdQjbG9DB+3+VpCXSsJXWY=;
 b=khWvfgt3WYuChNzKutm+WwuPZ+X+UyK58m32viLN2pjRCA7CTXdZZo2iKPPNOwQ4WA4LYrrZ7QFg4LQHOjPOOfsq8rrkgr/24nmEePFZ5cALfa8Gxt2hGPq6d0Gk9knsdrgUTe11qVHA+Tuzm4PSc1KGWuZZgUpd8hMg9rw0mCc6Os7NhbNH23bgTp5DUEhT4WTMSwh1/XenNBGbouVBCgVIwkzAStVd8ZYMOkF4Bk1O9KYsRZoxEJwLGSUgLJ7tB+syDJwc1It6sXY14EVhwZLBUsVK3erf76QsDAR9zZ3OxPQMKDilYrrojJS4qChDkXr3HKi2v0Zfqy7gmsF9SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MWHPR11MB1949.namprd11.prod.outlook.com (2603:10b6:300:110::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Wed, 30 Mar
 2022 02:46:23 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::d90e:5a21:8192:7c54]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::d90e:5a21:8192:7c54%7]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 02:46:23 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     syzbot <syzbot+4d0ae90a195b269f102d@syzkaller.appspotmail.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: RE: [syzbot] memory leak in gs_usb_probe
Thread-Topic: [syzbot] memory leak in gs_usb_probe
Thread-Index: AQHYQ4DV1H7CRbsUNkiTZLs8PGYT1KzXKcOAgAACewCAAArZIIAAAJGAgAABkPA=
Date:   Wed, 30 Mar 2022 02:46:22 +0000
Message-ID: <PH0PR11MB588040F5F12E2E4A3432583CDA1F9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <PH0PR11MB5880D33225C1E8A684BCFF64DA1F9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <0000000000002e8c1805db6673e2@google.com>
In-Reply-To: <0000000000002e8c1805db6673e2@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecb733d3-5dd6-4321-d20a-08da11f77a22
x-ms-traffictypediagnostic: MWHPR11MB1949:EE_
x-microsoft-antispam-prvs: <MWHPR11MB19499EA6A4AD5F0AF33F487BDA1F9@MWHPR11MB1949.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XHx/2uYP1k3X3gvKmhh7LaXdXuhV3EhrCaaKwoD0pOgFGSUa6sg3VOfFCB9pkrmxKGNoaf8nOsepAvWry5TlrhNd20Q5JoWFITRM2LYnL9b1ZyfM1eLMkVnZ9yamOLG1z4kHv7MHl4+98OmeAVCueUOqyDABx3Ccf+KB9wj2RGbwe6Cb7Ab7xoIDgoM9LtHmm4897JiMhibat2Kuof0GUQimR5EKPe6K5zktwgiWHVl/qZweiPt47MMrAl0bl10MPkTzTCi+T/sqeqwwY81hfmyrlPg7f4nafvFH3RaRT1Zxiz9RFkh9Oc9vsYs1wyT40qj6wK3U/V/qmmoGN6TcCqvak8XgAtyP1HrX+RzYiHZNy/uQ82Xdz0IkkYl0xVdQpDBSiAJRS61IGqAFRQWpCv5ZklSvVvKHF0swwxFo3Z1BfysFbPgmeAHcOBK0cmoV0sde4IuWgBj1uFd3SDHMccyrxycqXp7MbGomnnmC5BBFZirUZRnJGxBbALixpskkSqn7XKzej0P59v/6ny9uMIwGq5hnLFvfrFccACu4SimbmZDaXysCdR+TyH4809EZsPD++1kGsbivnNnb7OrDqmvn3l1QAYcC6VhKQ2QasyRwcRjh9gkiZ7uxi7o7Xl+W8TuwyrIv23sjzujVVUYQrBt6N3Pj+k9Y2H2rNrr2MBQqCMHkbRb6j/AgJ8yN7hVUhCGamnnzMin8OG4A03qhBlbVGhzpDU8N7tTspRyItbQN47rJ6jy9riWzdVz4oCrQfK0ZG9FlZcgXyqKDBZJ3xZI7NjGd/s3mRA3oIu3zxg0Vj3dXlHxgUoADgEC7yBMli191RXrer2D87Gx1XOmDKqwCx0owsvTRM5qbI5zK3Ek=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(966005)(5660300002)(8936002)(4744005)(82960400001)(508600001)(2906002)(122000001)(38100700002)(38070700005)(86362001)(110136005)(316002)(9686003)(186003)(26005)(52536014)(66946007)(8676002)(64756008)(66556008)(66476007)(66446008)(6506007)(76116006)(7696005)(55016003)(71200400001)(33656002)(99710200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDhXK1Q1ZCtHOUM0UitRYXZ0N0J5clA4cVNFMTNmUzU0N3BQbndlUS9BZ0Nl?=
 =?utf-8?B?Q2ZIYXlsQmt6emxnbEllNE1RbVVXOEtMVkdCT1dxcW9BWWlGRHRQdjJXWHFs?=
 =?utf-8?B?bW95NTQ2bWN3WU93em80OXNqSGloWnh4bkVVbmtFOTNDbWxWb3hXbVRwOUVU?=
 =?utf-8?B?cmFjb3NBSTBoL0JMRGJRY0lyelhtZnZRVXhucVFtMnRIOXZCQWNQKzVpbEVw?=
 =?utf-8?B?NzY0ZEZEVjZBTlRyV0pieVQxR2RHemZhVzI4Ykd6MlM3YlNybENQd1l1MzZm?=
 =?utf-8?B?L0lkSlcrQ1AwNVc2NCtDRzZpbkFLbCs4QVBCS3hTekh1MXd2bTBiRm9zQ215?=
 =?utf-8?B?UExkL0g3Z2cvMkNKY0tpbDNHRTF2c2N3QjJ1NU4zT1NrS2V2ZzFXVGpHNEtn?=
 =?utf-8?B?K3gxK1d5ajVMdmRvRTV4TG5Wdmd6dERkUEtRbUowK3NEK0RQaVVPbC9MellV?=
 =?utf-8?B?L1lpemIrRXVKaHNKSExYTld3anVvQ013ZVVKb053NEZvU1NtV1pVKy93eTlz?=
 =?utf-8?B?UEJOamdsSVY4eEwreW9VODFUdFRTTDdBYTNrdVJva244OHlCMDJ6NkJabXJF?=
 =?utf-8?B?QWxnbHM3YkVCWm9pbG5HcFFFRTFiZml0T3dYZnRsOW9ESTBRdld0N1pQOFpF?=
 =?utf-8?B?MFZqWWNmclRVWHRmd3lidnBPblBaZmk2VkFUNE52UDhWZDR6N09yOUhIc3pB?=
 =?utf-8?B?djlORER0Z3Z0bWdkVGd0b2Z1Ymw5RlNQSmxrcGFvOS8xRy9xZmVMSlFpa3Z3?=
 =?utf-8?B?RGZkZGFvWG5paHV3YUM1aHBaYzB0ZEF2NDFQOGdoK3Zta2Z6eEd3cWpOSE53?=
 =?utf-8?B?L05pNHlzL2FvdzNoNWI1RDlqc3hkb2U1Q0dEZWpGU3ZlaVVaRGNlY2VLOGFK?=
 =?utf-8?B?RmVFUHN6Qm5EWGpNZHcrUDlNTjd0MDl4Q3FOdVdxRDAwRFUzMGtzdUJhWW9o?=
 =?utf-8?B?ZFZPUTdRc0swV0t5VjVOVGNnYVhzZkppdW5TZW8yNXhSSW13S0JnZXZ4S1Fs?=
 =?utf-8?B?UXNMaldqZkVVK2dvTkF4WW9GTnNBVFYyYng1YVdaNHo2MFlyK1hyZTh4Z25F?=
 =?utf-8?B?SDE2aHdXWWQvdzdzMjZncG1NMWJKWVpUaW5RZjFLa3M3ZU1ISkNUR254UHl6?=
 =?utf-8?B?S2lnNGU0RGlIQjhVMm9nRURIK05EKzBDdkRNTHlFL1ZtaEVaSVFEeTMyOHpZ?=
 =?utf-8?B?T1NsU3BxcXlUaThvc2k0Tzd1aU1Ja1lqTlZzZ1ZwNklmQzk3cTFOSWpvY0ww?=
 =?utf-8?B?OTFaNE9YQWVuOU4yLzJJMTZ0bDlHZVIyZWI1cUg4aU54c2s3QzdGa1FwZDNB?=
 =?utf-8?B?NVZaVFJrSm40SHY1TmVXbmp2NlNxNmNGTm9uZStBZXppSWRjOVhwNTdScUI4?=
 =?utf-8?B?WWIvZ2J5M1MvSC9zNG1pZzRYK2ZxQ0owL2h0VWg0L3hGR3l1ZzdwSk91ZCtK?=
 =?utf-8?B?Q1NqTjhzV0s4YXNtcHp6M0ZKZ3ByUUJaRDVRRG5IVmpoSTliV1Z6N3N3aEtO?=
 =?utf-8?B?WXhzNXpCTXVDY2pER0IwU3FobGd4SS9EY2NnZUFJRlJYUERyRWpLa2xLN3JU?=
 =?utf-8?B?YlhadnExZXZEOUx6dlBSZ0RvaFVYYUZKWERTYm5vYWZKVUdKbTVYT1lFUWtT?=
 =?utf-8?B?bHpOdmFSNlpYUzdYRDlOVTd3bU8xUU5oYXJFaUtRS2pqdE5wWHFzeGkvUnNG?=
 =?utf-8?B?Y2xxanpEWVJSU2N4RDNXbEtiTG5DZERJRVFhdndaOVBWSXZzMFpINGpuR3hP?=
 =?utf-8?B?L1BrR0c2OVRmeVhUQWNXNHlNQkxsd2lBSVhiS3MxNVFZcEozUWV1bzNWV1B4?=
 =?utf-8?B?UW5kUjBTbzU3WXMwbk9nVGgvV3JkcndWb1Q1SUxZbzYrRU1wUVBodWJKV0Vv?=
 =?utf-8?B?ZWJ5cGVrQXpHVmlUM0VzVzRmQ0ZWKzZ5Z3dDOVJMZFp2OGdXSG1FNTlsSTdV?=
 =?utf-8?B?eER3RlNvVlB2ODhSK0RJSFZsL0RUcDdjWEFXZ0ZXbm1TdCtoZjZ5aGFpa2xv?=
 =?utf-8?B?dHR4Y3FLNkVSYS9JMTZFSC82VDJWNGR1eGZsa21GZDI5cjVWd09ndHN4dDBB?=
 =?utf-8?B?WEMzaEUwdXd3a0hHV3JUQnJ5R0VSc24xOFlMc1RCc1VPMWtQWEo2eEJ6L3Nw?=
 =?utf-8?B?SFljdUFnd3pFS3VQU2dXMmQ0bXZlRWlHUGZhOWNSeUlWUnBiUkdXaG9xS2Zt?=
 =?utf-8?B?U0FYUVVKdjlJTXlTQ0tVZFN2Mk8wSmI5a0FNVCtjWmFtTk9XK2tBR3I0dEZG?=
 =?utf-8?B?SWdqQUhzd0VrelZwaHR5U1hIUGcwYUVKT0YzUUM1Q1F6YndKQk84cEdHdkV0?=
 =?utf-8?B?OEoyTGc4NHFZbmNGNDN0bDhmR295TnB2aGdiNnB6VHRpZUZMdmRGUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb733d3-5dd6-4321-d20a-08da11f77a22
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 02:46:22.9250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g/xV9Z25aTZtRX2LfZ/hk2aSmKPuSpxVzyftF5njHasue9mQ4+8F0PdkLV9FF0JtvfamuPtxyHB1qA2SjH7Jfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1949
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGVsbG8sDQoNCnN5emJvdCB0cmllZCB0byB0ZXN0IHRoZSBwcm9wb3NlZCBwYXRjaCBidXQgdGhl
IGJ1aWxkL2Jvb3QgZmFpbGVkOg0KDQpmYWlsZWQgdG8gYXBwbHkgcGF0Y2g6DQpjaGVja2luZyBm
aWxlIGRyaXZlcnMvbmV0L2Nhbi91c2IvZ3NfdXNiLmMNCnBhdGNoOiAqKioqIHVuZXhwZWN0ZWQg
ZW5kIG9mIGZpbGUgaW4gcGF0Y2gNCg0KDQoNClRlc3RlZCBvbjoNCg0KY29tbWl0OiAgICAgICAg
IGMyNTI4YTBjIEFkZCBsaW51eC1uZXh0IHNwZWNpZmljIGZpbGVzIGZvciAyMDIyMDMyOQ0KZ2l0
IHRyZWU6ICAgICAgIGxpbnV4LW5leHQNCmRhc2hib2FyZCBsaW5rOiBodHRwczovL3N5emthbGxl
ci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9NGQwYWU5MGExOTViMjY5ZjEwMmQNCmNvbXBpbGVyOiAg
ICAgICANCnBhdGNoOiAgICAgICAgICBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94L3Bh
dGNoLmRpZmY/eD0xNjZhMzNhYjcwMDAwMA0KDQoNCiNzeXogdGVzdDogIGdpdDovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXh0L2xpbnV4LW5leHQuZ2l0ICBtYXN0
ZXINCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi91c2IvZ3NfdXNiLmMgYi9kcml2ZXJz
L25ldC9jYW4vdXNiL2dzX3VzYi5jIGluZGV4IDY3NDA4ZTMxNjA2Mi4uNTIzNGNmZmY4NGI4IDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvY2FuL3VzYi9nc191c2IuYw0KKysrIGIvZHJpdmVycy9u
ZXQvY2FuL3VzYi9nc191c2IuYw0KQEAgLTEwOTIsNiArMTA5Miw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
Z3NfY2FuICpnc19tYWtlX2NhbmRldih1bnNpZ25lZCBpbnQgY2hhbm5lbCwNCiAgICAgICAgICAg
ICAgICBkZXYtPmRhdGFfYnRfY29uc3QuYnJwX2luYyA9IGxlMzJfdG9fY3B1KGJ0X2NvbnN0X2V4
dGVuZGVkLT5kYnJwX2luYyk7DQoNCiAgICAgICAgICAgICAgICBkZXYtPmNhbi5kYXRhX2JpdHRp
bWluZ19jb25zdCA9ICZkZXYtPmRhdGFfYnRfY29uc3Q7DQorICAgICAgICAgICAgICAga2ZyZWUo
YnRfY29uc3RfZXh0ZW5kZWQpOw0KICAgICAgICB9DQoNCiAgICAgICAgU0VUX05FVERFVl9ERVYo
bmV0ZGV2LCAmaW50Zi0+ZGV2KTsNCg==
